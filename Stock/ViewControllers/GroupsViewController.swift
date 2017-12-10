import UIKit

typealias Groups = [Group]

final class GroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groups: Groups = [Group(title: "성장", note: "성장하는 종목들")]
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(deleteGroup(_:)), name: Group.didDelete, object: nil)
        title = "그룹"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-add_folder"), style: .plain, target: self, action: #selector(newGroup))
        tableView.separatorColor = .separator
        tableView.hideBottonSeperator()
        reload()
    }
    
    @objc func deleteGroup(_ notification: Notification) {
        guard let group = notification.object as? Group  else { return }
        guard let index = groups.index(where: {  $0.title == group.title }) else { return }
        removeGroupAt(index)
    }
    
    @objc func newGroup() {
        let editGroupViewController = GroupEditViewController(group: nil)
        editGroupViewController.didSaveGroup = { group in
            self.groups.append(group)
            self.saveGroups()
        }
        let navigationController = UINavigationController(rootViewController: editGroupViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func reload() {
        if let data = UserDefaults.standard.object(forKey: "groups") as? Data {
            groups = try! PropertyListDecoder().decode(Groups.self, from: data)
        }
        tableView.reloadData()
    }
    
    func saveGroups() {
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(groups), forKey: "groups")
        if UserDefaults.standard.synchronize() {
            tableView.reloadData()
        }
    
    }
    
    private func removeGroupAt(_ index: Int) {
        groups.remove(at: index)
        saveGroups()
    }
    
}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeGroupAt(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = groups[indexPath.row].title
        return cell
    }
}

extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let editGroupViewController = GroupEditViewController(group: groups[indexPath.row])
        editGroupViewController.didSaveGroup = { group in
            self.saveGroups()
            self.tableView.reloadData()
        }
        let navigationController = UINavigationController(rootViewController: editGroupViewController)
        present(navigationController, animated: true, completion: nil)
        
    }
}
