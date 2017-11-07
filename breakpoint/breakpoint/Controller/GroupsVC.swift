//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    var groups = [Group]()
    
    @IBOutlet weak var groupsTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsTbl.delegate = self
        groupsTbl.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_GROUPS.observe(.value) { (dataSnapshot) in
            DataService.instance.getAllGroups { (groups) in
                self.groups = groups
                
                self.groupsTbl.reloadData()
            }
        }
    }
}

extension GroupsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else { return }
        
        let group = groups[indexPath.row]
        
        groupFeedVC.initGroupData(forGroup: group)
        
        presentDetail(groupFeedVC)
        //present(groupFeedVC, animated: true, completion: nil)
    }
}

extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        
        let group = groups[indexPath.row]
        
        cell.configureCell(withTitle: group.groupTitle, andDescription: group.groupDescription, havingMembers: group.members.count)
        
        return cell
    }
}

