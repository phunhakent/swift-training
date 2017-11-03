//
//  ProfileVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var emaiLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var profileTbl: UITableView!
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (_) in
            do {
                try Auth.auth().signOut()
                
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emaiLbl.text = Auth.auth().currentUser?.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
