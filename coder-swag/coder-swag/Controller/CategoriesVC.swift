//
//  ViewController.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {

    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductVC",
            let productVC = segue.destination as? ProductVC,
            let category = sender as? Category {
            
            let barButtonItem = UIBarButtonItem()
            barButtonItem.title = ""
            
            navigationItem.backBarButtonItem = barButtonItem
            
            assert(sender as? Category != nil)
            productVC.initProducts(forCategory: category)
        }
    }
}

// MARK: - UITableViewDataSource
extension CategoriesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCategories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
            let category = DataService.instance.getCategories()[indexPath.row]
            
            cell.updateView(category: category)
            
            return cell
        }
        
        return CategoryCell()
    }
}

// MARK: - UITableViewDelegate
extension CategoriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = DataService.instance.getCategories()[indexPath.row]
        
        performSegue(withIdentifier: "ProductVC", sender: category)
    }
}
