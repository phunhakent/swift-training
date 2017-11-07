//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/7/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var emaiLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    func configureCell(profileImg: UIImage, email: String, content: String) {
        emaiLbl.text = email
        contentLbl.text = content
        self.profileImg.image = profileImg
    }
}
