//
//  CreateGoalVC.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    var goalType: GoalType = .ShortTerm {
        didSet {
            switch goalType {
            case .LongTerm:
                shortTermBtn.setDeselectedColor()
                longTermBtn.setSelectedColor()
            case .ShortTerm:
                shortTermBtn.setSelectedColor()
                longTermBtn.setDeselectedColor()
            }
        }
    }
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        guard let goalDescription = goalTextView.text, !goalDescription.isEmpty, goalDescription != "What is your goal",
            let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {
            return
        }
        
        finishGoalVC.initData(description: goalDescription, type: goalType)
        
        presentingViewController?.presentSecondDetail(finishGoalVC)
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .ShortTerm
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .LongTerm
    }
    
    @IBAction func backBtnPRessed(_ sender: Any) {
        dismissDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.bindToKeyboard()
        
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        
        goalTextView.delegate = self
    }
}


extension CreateGoalVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text == "What is your goal?" {
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textView.text = ""
        }
    } 
}

