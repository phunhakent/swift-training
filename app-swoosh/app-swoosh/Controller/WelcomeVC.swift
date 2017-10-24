//
//  ViewController.swift
//  app-swoosh
//
//  Created by Kent Nguyen on 10/24/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var swoosh: UIImageView!
    @IBOutlet weak var bgImg: UIImageView!
    
    // MARK: - IBAction

    @IBAction func unwindFromSkillVC(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

