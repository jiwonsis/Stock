//
//  GroupsViewController.swift
//  Stock
//
//  Created by Scott moon on 04/12/2017.
//  Copyright © 2017 Scott moon. All rights reserved.
//

import UIKit

typealias Groups = [Group]

final class GroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groups = [Group]()
}

extension GroupsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        
        if let groups = loadData() {
            self.groups = groups
        }
    }
}

private extension GroupsViewController {
    func setupNavigationUI() {
        title = "그룹"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-add_folder"), style: .plain, target: self, action: #selector(newGroup))
    }
    
    @objc func newGroup() {
        let editGroupViewController = EditGroupViewController(group: nil)
        editGroupViewController.didSaveGroup = { group in
            self.groups.append(group)
            self.saveGroup()
            self.tableView.reloadData()
        }
        
        present(UINavigationController(rootViewController: editGroupViewController), animated: true, completion: nil)
        
    }
    
    func saveGroup() {
        saveData(groups: groups)
    }
}

private extension GroupsViewController {
    func saveData(groups: [Group]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(groups), forKey: "groups")
        UserDefaults.standard.synchronize()
    }
    
    func loadData() -> [Group]? {
        if let data = UserDefaults.standard.object(forKey: "groups") as? Data {
            return try! PropertyListDecoder().decode(Groups.self, from: data)
        }
        return nil
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let editGroupViewController = EditGroupViewController(group: groups[indexPath.row])
        present(UINavigationController(rootViewController: editGroupViewController), animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = groups[indexPath.row].title
        return cell
    }
}
