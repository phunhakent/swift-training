//
//  ChatVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    var isTyping = false
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoggedInMessages()
        } else {
            channelNameLbl.text = "Please Log In"
            messagesTbl.reloadData()
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
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUserLbl: UILabel!
    
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
                    
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, MessageService.instance.selectedChannel!.id)
                }
            })
        }
    }
    
    @IBAction func messageTxtDidChange(_ sender: Any) {
        if messageTxt.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, MessageService.instance.selectedChannel!.id)
        } else {
            if !isTyping {
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, MessageService.instance.selectedChannel!.id)
            }
            
            isTyping = true
        }
        
        
        if let msg = messageTxt.text, !msg.isEmpty {
            sendBtn.isHidden = false
        } else {
            sendBtn.isHidden = true
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
        
        SocketService.instance.getChatMessages { (success) in
            if success {
                self.messagesTbl.reloadData()
                
                if MessageService.instance.messages.count > 0 {
                    let indexPath = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.messagesTbl.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0  && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                
                self.typingUserLbl.text = "\(names) \(verb) typing a message..."
            } else {
                self.typingUserLbl.text = ""
            }
        }
        
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
