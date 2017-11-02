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
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal) {
        goalDescriptionLbl.text = goal.goalDescription!
        goalTypeLbl.text = goal.goalType!
        goalProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletion {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}
