//
//  Category.swift
//  coder-swag
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

struct Category {
    private(set) var title: String!
    private(set) var imageName: String!
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
