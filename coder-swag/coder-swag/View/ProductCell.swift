//
//  ProductCell.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    
    func updateCell(withProduct product: Product) {
        productTitle.text = product.title
        priceTitle.text = product.price
        productImage.image = UIImage(named: product.imageName)
    }
}
