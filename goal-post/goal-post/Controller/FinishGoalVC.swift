//
//  FinishGoalVC.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {

    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    func save(completion: @escaping (_ success: Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = self.goalDescription
        goal.goalType = self.goalType.rawValue
        goal.goalCompletion = Int32(pointTxt.text!)!
        goal.goalProgress = 0
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
    @IBOutlet weak var pointTxt: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if pointTxt.text != nil {
            save { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGoalBtn.bindToKeyboard()
        
        pointTxt.delegate = self
    }
}


extension FinishGoalVC: UITextFieldDelegate {
    
}
