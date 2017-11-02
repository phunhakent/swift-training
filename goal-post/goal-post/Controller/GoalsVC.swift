//
//  ViewController.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var goalsTbl: UITableView!
    
    @IBAction func addGoalBtnPressed(_ sender: Any) {
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTbl.delegate = self
        goalsTbl.dataSource = self
        
        
    }
}


extension GoalsVC: UITableViewDelegate {
}

extension GoalsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(description: "Just a test", type: GoalType.LongTerm, goalProgressAmount: 4)
        
        return cell
    }
}

