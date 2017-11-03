//
//  FeedCell.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
 
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    func configureCell(userImg: UIImage, email: String, message: String) {
        self.userImg.image = userImg
        emailLbl.text = email
        messageLbl.text = message
    }
}
