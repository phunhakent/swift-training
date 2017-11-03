//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
 
    var messageArray = [Message]()
    
    @IBOutlet weak var feedTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTbl.delegate = self
        feedTbl.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (reponseMessages) in
            self.messageArray = reponseMessages.reversed()
            
            self.feedTbl.reloadData()
        }
    }
}

extension FeedVC: UITableViewDelegate {
    
}

extension FeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        
        let img = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (username) in
            if let username = username, let img = img {
                cell.configureCell(userImg: img, email: username, message: message.content)
            }
        }
        
        return cell
    }
}

