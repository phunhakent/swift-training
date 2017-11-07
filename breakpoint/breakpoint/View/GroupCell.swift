//
//  GroupCell.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/6/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    
    func configureCell(withTitle title: String, andDescription description: String, havingMembers members: Int) {
        groupTitleLbl.text = title
        groupDescriptionLbl.text = description
        groupMembersLbl.text = "\(members) members"
    }
}
