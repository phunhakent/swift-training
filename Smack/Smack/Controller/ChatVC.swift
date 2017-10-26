//
//  ChatVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    
    
    // MARK: - IBOutlet
    @IBOutlet weak var menuBtn: UIButton!
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //revealViewController implement
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
