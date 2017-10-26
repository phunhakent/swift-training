//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // MARK: - IBAction
    @IBAction func closeBtnPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
