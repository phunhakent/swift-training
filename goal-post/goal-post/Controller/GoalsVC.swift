//
//  ViewController.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    var goals = [Goal]()
    
    func set(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletion {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetch(completion: (_ success: Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            self.goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    @IBOutlet weak var goalsTbl: UITableView!
    
    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else {
            return
        }
        
        presentDetail(createGoalVC)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTbl.delegate = self
        goalsTbl.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetch { (success) in
            if success {
                goalsTbl.isHidden = goals.count == 0
                goalsTbl.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate
extension GoalsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.fetch { (success) in
                if success {
                    self.goalsTbl.isHidden = self.goals.count == 0
                    self.goalsTbl.reloadData()
                }
            }
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addProgressAction = UITableViewRowAction(style: .normal, title: "1+") { (_, indexPath) in
            self.set(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addProgressAction.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        
        return [deleteAction, addProgressAction]
    }
}

// MARK: - UITableViewDataSource
extension GoalsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else {
            return UITableViewCell()
        }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        
        return cell
    }
}

