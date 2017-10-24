//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by Kent Nguyen on 10/24/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {

    // MARK: IBAction
    
    @IBAction func onNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
