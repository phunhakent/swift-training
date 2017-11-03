//
//  LoginVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTf: InsetTextField!
    @IBOutlet weak var passwordTf: InsetTextField!
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        guard let email = emailTf.text, !email.isEmpty,
            let password = passwordTf.text, !password.isEmpty else {
            return
        }
        
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print(String.init(describing: error?.localizedDescription))
            }
            
            AuthService.instance.registerUser(withEmail: email, andPassword: password, userCreationComplete: { (success, error) in
                if success {
                    AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
                        print("Successfully registered user")
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print(String.init(describing: error?.localizedDescription)) 
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTf.delegate = self
        passwordTf.delegate = self
    }
}

extension LoginVC: UITextFieldDelegate {
    
}
