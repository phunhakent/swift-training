//
//  ChatVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoggedInMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func tapHandler(_ gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else {
            return
        }
        
        MessageService.instance.findAllMessages(forChannelId: channelId) { (success) in
            if success {
                self.messagesTbl.reloadData()
            }
        }
    }
    
    func updateWithChannel() {
        let selectedChannel = MessageService.instance.selectedChannel
        
        channelNameLbl.text = "#\(selectedChannel?.title ?? "")"
        
        getMessages()
    }
    
    func onLoggedInMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                MessageService.instance.selectedChannel = MessageService.instance.channels.first
                
                if MessageService.instance.selectedChannel != nil {
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet"
                }
            }
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var messagesTbl: UITableView!
    
    // MARK: - IBAction
    @IBAction func sendMsgPressed(_ sender: Any) {
        if (AuthService.instance.isLoggedIn) {
            guard let channelId = MessageService.instance.selectedChannel?.id,
                let content = messageTxt.text else {
                return
            }
            
            SocketService.instance.addMessage(content: content, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                }
            })
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //revealViewController implement
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        } 
        
        view.bindToKeyboard()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatVC.tapHandler(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        messagesTbl.dataSource = self
        messagesTbl.delegate = self
        messagesTbl.estimatedRowHeight = 80
        messagesTbl.rowHeight = UITableViewAutomaticDimension
    }
}

// MARK: - UITableViewDelegate
extension ChatVC: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            cell.configureCell(message: MessageService.instance.messages[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}
