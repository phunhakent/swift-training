//
//  CreateGoalVC.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
    }
    @IBAction func backBtnPRessed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
}
