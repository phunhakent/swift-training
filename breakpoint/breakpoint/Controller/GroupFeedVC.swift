//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/7/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    var group: Group?
    var messages = [Message]()
    
    func initGroupData(forGroup group: Group) {
        self.group = group
    }
    
    @IBOutlet weak var feedTbl: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messgageTf: InsetTextField!
    @IBOutlet weak var sendContainerView: UIView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        dismissDetail()
    }
     
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messgageTf.text != "" {
            messgageTf.isEnabled = false
            sendBtn.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: messgageTf.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (success) in
                if success {
                    self.messgageTf.isEnabled = true
                    self.messgageTf.text = ""
                    self.sendBtn.isEnabled = true
                    
                    if !self.messages.isEmpty {
                        self.feedTbl.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendContainerView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmails(forGroup: group!) { (emails) in
            self.membersLbl.text = emails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, completion: { (messages) in
                self.messages = messages
                
                self.feedTbl.reloadData()
            })
        }
    }
}

extension GroupFeedVC: UITableViewDelegate {
    
}

extension GroupFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {
            return UITableViewCell()
        }
        
        let message = messages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImg: UIImage(named: "defaultProfileImage")!, email: email!, content: message.content)
        }
        
        return cell
    }
}
