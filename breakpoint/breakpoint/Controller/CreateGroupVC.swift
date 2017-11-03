//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/4/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    
    @IBOutlet weak var titleTf: InsetTextField!
    @IBOutlet weak var descriptionTf: InsetTextField!
    @IBOutlet weak var emailSearchTf: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
