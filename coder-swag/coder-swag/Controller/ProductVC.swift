//
//  ProductVC.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    private(set) var products = [Product]()
    
    func initProducts(forCategory category: Category) {
        products = DataService.instance.getProducts(forCategoryTitle: category.title)
        
        navigationItem.title = category.title
    }
    
    @IBOutlet weak var productsColelction: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsColelction.delegate = self
        productsColelction.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension ProductVC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ProductVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = productsColelction.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.updateCell(withProduct: products[indexPath.row])
            
            return cell
        }
        
        return ProductCell(
    }
}
