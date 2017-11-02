//
//  GoalCell.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: GoalType, goalProgressAmount: Int) {
        goalDescriptionLbl.text = description
        goalTypeLbl.text = type.rawValue
        goalProgressLbl.text = String.init(describing: goalProgressAmount)
    }
}
