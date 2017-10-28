//
//  LoginVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - IBAction
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = usernameTxt.text, !email.isEmpty,
            let password = passwordTxt.text, !password.isEmpty
        else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func unwindToLoginVC(withSegue segue: UIStoryboardSegue) {
    
    }
    
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(spinner.isHidden)
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [ NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder ])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [ NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder ])
    }
}
