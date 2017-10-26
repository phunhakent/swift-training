//
//  Product.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

struct Product {
    private(set) var title: String
    private(set) var price: String
    private(set) var imageName: String
    
    init(title: String, price: String, imageName: String) {
        self.title = title
        self.price = price
        self.imageName = imageName
    }
}
