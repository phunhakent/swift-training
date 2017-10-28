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
    var bgColor: UIColor? {
        didSet {
            if let color = bgColor {
                UIView.animate(withDuration: 0.2, animations: {
                    self.userImg.backgroundColor = color
                })
            }
        }
    }
    
    func setupView() {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTab))
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTab() {
        view.endEditing(true)
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
        
        spinner.startAnimating()
        
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success) in
            if success {
                print("Success")
                
                AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (loginSuccess) in
                    if loginSuccess {
                        AuthService.instance.createUser(haveName: name, andEmail: email, andAvatar: self.avatarName, withColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                print(UserDataService.instance.name, UserDataService.instance.email)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvaPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDataService.instance.avatarName.isEmpty {
            avatarName = UserDataService.instance.avatarName
            userImg.image = UIImage(named: avatarName)
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
}
