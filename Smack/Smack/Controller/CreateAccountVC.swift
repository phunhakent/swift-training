//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    // MARK: - IBOutlet
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // MARK: - IBAction
    @IBAction func closeBtnPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let email = emailTxt.text, !email.isEmpty,
            let password = passwordTxt.text, !password.isEmpty,
            let name = usernameTxt.text, !name.isEmpty else {
            return
        }
        
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success) in
            if success {
                print("Success")
                
                AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (loginSuccess) in
                    if loginSuccess {
                        AuthService.instance.createUser(haveName: name, andEmail: email, andAvatar: self.avatarName, withColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.email)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvaPressed(_ sender: Any) {
    }
    
    @IBAction func pickBgPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
