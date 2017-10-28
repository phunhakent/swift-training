//
//  ChannelVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: UIControlState.normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
    @objc func userDataChanged(_ notif: Notification) {
        setupUserInfo()
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var channelsTbl: UITableView!
    
    // MARK: - IBAction
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    @IBAction func createChannelPressed(_ sender: Any) {
        let addChannelVC = AddChannelVC()
        
        addChannelVC.modalPresentationStyle = .custom
        
        present(addChannelVC, animated: true, completion: nil)
    }
    
    @IBAction func unwindToChannelVC(withSegue segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        channelsTbl.dataSource = self
        channelsTbl.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUserInfo()
    }
}

// MARK: - UITableViewDelegate
extension ChannelVC: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension ChannelVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            
            cell.configureCell(withChannel: MessageService.instance.channels[indexPath.row])
            
            return cell
        }
        
        return ChannelCell()
    }
    
}
