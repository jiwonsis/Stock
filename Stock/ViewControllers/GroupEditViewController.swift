//
//  GroupEditViewController.swift
//  Stock
//
//  Created by Scott moon on 04/12/2017.
//  Copyright © 2017 Scott moon. All rights reserved.
//

import UIKit

class GroupEditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let group : Group?
    
    var titleField: UITextField?
    var noteField: UITextField?
    
    var didSaveGroup: ((Group) -> Void)?
    
    init(group: Group?) {
        self.group = group
        super.init(nibName: nil, bundle:  nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GroupEditViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationUI()
        setupTableContent()
        view.backgroundColor = .backgroundView
        tableView.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleField?.becomeFirstResponder()
    }
}

private extension GroupEditViewController {
    func setupNavigationUI() {
        title = "새 그룹"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel_))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave_))
    }
    
    @objc func onCancel_() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onSave_() {
        
        guard let title = titleField?.text, let note = noteField?.text, !title.isEmpty else { return }
        
        if let group = group {
            group.title = title
            group.note = note
            didSaveGroup?(group)
        } else {
            let newGroup = Group(title: title, note: note)
            didSaveGroup?(newGroup)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupTableContent() {
        let identifier = TextFieldTableViewCell.reuseIdentifier
        tableView.register(UINib(nibName: identifier, bundle: nil),
                           forCellReuseIdentifier: identifier)
    }
    
    func onDelete_() {
        let avc = UIAlertController(title: "그룹 삭제", message: "정말로 그룹을 삭제 하시겠습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        avc.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            NotificationCenter.default.post(name: Group.didDelete, object: self.group, userInfo: nil)
            self.dismiss(animated: true, completion: nil)
        }
        avc.addAction(deleteAction)
        
        present(avc, animated: true, completion: nil)
    }
    
    
}

extension GroupEditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return group == nil ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else if section == 1{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        onDelete_()
    }
}

extension GroupEditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        emptyView.backgroundColor = .clear
        return emptyView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath) as! TextFieldTableViewCell
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                cell.titleLabel.text = "그룹 명:"
                cell.inputField.placeholder = "그룹 명을 입력해주세요"
                cell.inputField.text = group?.title
                titleField  = cell.inputField
                titleField?.delegate = self
                titleField?.returnKeyType = .next
                
                return cell
                
            } else if indexPath.row == 1 {
                
                cell.titleLabel.text = "설명:"
                cell.inputField.placeholder = "그룹에 대한 설명을 입력해주세요"
                cell.inputField.text = group?.note
                noteField  = cell.inputField
                noteField?.delegate = self
                noteField?.returnKeyType = .done
                
                return cell
            }
            
        } else if indexPath.section == 1 {
            
            let removeCell = UITableViewCell()
            removeCell.textLabel?.text = "그룹 삭제"
            removeCell.textLabel?.textColor = .red
            removeCell.textLabel?.textAlignment = .center
            removeCell.selectionStyle = .none
            return removeCell
            
        }
        
        return UITableViewCell()
    }
}

extension GroupEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
            noteField?.becomeFirstResponder()
        } else if textField == noteField {
            onSave_()
        }
        return true
    }
}
