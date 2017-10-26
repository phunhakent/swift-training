//
//  DataService.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation
class DataService {
    static let instance = DataService()
    
    private let categories = [
        Category(title: "SHIRTS", imageName: "shirts.png"),
        Category(title: "HOODIES", imageName: "hoodies.png"),
        Category(title: "HATS", imageName: "hats.png"),
        Category(title: "DIGITAL", imageName: "digital")
    ]
    
    private let hats = [
        Product(title: "dev logo graphic beanie", price: "$18", imageName: "hat01.png"),
        Product(title: "blue hat", price: "$22", imageName: "hat02.png"),
        Product(title: "green hat", price: "$45", imageName: "hat03.png"),
        Product(title: "white hat", price: "$56", imageName: "hat04.png"),
    ]
    
    private let hoodies = [
        Product(title: "dev logo hoodie grey", price: "$18", imageName: "hoodie01.png"),
        Product(title: "dev logo hoodie blue", price: "$18", imageName: "hoodie02.png"),
        Product(title: "dev logo hoodie green", price: "$18", imageName: "hoodie03.png"),
        Product(title: "dev logo hoodie red", price: "$18", imageName: "hoodie04.png"),
        ]
    
    private let shirts = [
        Product(title: "dev logo shirt grey", price: "$18", imageName: "shirt01.png"),
        Product(title: "dev logo shirt blue", price: "$18", imageName: "shirt02.png"),
        Product(title: "dev logo shirt green", price: "$18", imageName: "shirt03.png"),
        Product(title: "dev logo shirt red", price: "$18", imageName: "shirt04.png"),
        ]
    
    private let digitals = [Product]()
    
    func getCategories() -> [Category]{
        return categories
    }
    
    func getProducts(forCategoryTitle title: String) -> [Product] {
        switch title {
        case "SHIRTS":
            return shirts
        case "HOODIES":
            return hoodies
        case "HATS":
            return hats
        case "DIGITAL":
            return digitals
        default:
            return []
        }
    }
}
