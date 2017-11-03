//
//  AuthVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {
  
    @IBAction func emailLogInBtnPressed(_ sender: Any) {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            present(loginVC, animated: true, completion: nil)
        }
    }
    @IBAction func googleLogInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookLogInBtnPressed(_ sender: Any) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            dismiss(animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
