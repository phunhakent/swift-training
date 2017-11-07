//
//  UserCell.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/4/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var checkImg: UIImageView!

    func configureCell(email: String, userImage: UIImage, isSelected: Bool) {
        emailLbl.text = email
        userImg.image = userImage
        checkImg.isHidden = !isSelected
    }
    
    func selectUser(isSelected: Bool) {
        checkImg.isHidden = !isSelected
    }
}
