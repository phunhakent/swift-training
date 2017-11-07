//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/4/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    var emailArray = [String]()
    var selectedEmailArray = Set<String>()
    
    @objc func emailSearchTfDidChange(_ sender: UITextField) {
        if emailSearchTf.text == nil || emailSearchTf.text == "" {
            emailArray = []
            usersTbl.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTf.text!, handler: { (emails) in
                self.emailArray = emails
                self.usersTbl.reloadData()
            })
        }
    }
    
    @IBOutlet weak var usersTbl: UITableView!
    @IBOutlet weak var titleTf: InsetTextField!
    @IBOutlet weak var descriptionTf: InsetTextField!
    @IBOutlet weak var emailSearchTf: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        DataService.instance.getIds(forUserNames: Array(selectedEmailArray)) { (userIds) in
            var allUserIds = Array(userIds)
            allUserIds.append(Auth.auth().currentUser!.uid)
            
            DataService.instance.createGroup(withTitle: self.titleTf.text!, andDescription: self.descriptionTf.text!, forUserIds: allUserIds, completion: { (success) in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailSearchTf.addTarget(self, action: #selector(emailSearchTfDidChange), for: .editingChanged)
        doneBtn.isHidden = true
    }
}

extension CreateGroupVC: UITextFieldDelegate {
    
}

extension CreateGroupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            let userEmail = emailArray[indexPath.row]
            let alreadySelected = selectedEmailArray.contains(userEmail)
            
            cell.selectUser(isSelected: !alreadySelected)
            
            if alreadySelected {
                selectedEmailArray.remove(userEmail)
            } else {
                selectedEmailArray.insert(userEmail)
            }
            
            if selectedEmailArray.isEmpty {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            } else {
                groupMemberLbl.text = "add \(selectedEmailArray.joined(separator: ", ")) to your group"
                doneBtn.isHidden = false
            }
        }
    }
}

extension CreateGroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        
        let userEmail = emailArray[indexPath.row]
        
        let profileImage = UIImage(named: "defaultProfileImage")
        
        cell.configureCell(email: userEmail, userImage: profileImage!, isSelected: selectedEmailArray.contains(userEmail))
        
        return cell
    }
}
