//
//  LoginVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: - IBAction
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func unwindToLoginVC(withSegue segue: UIStoryboardSegue) {
    
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
}
