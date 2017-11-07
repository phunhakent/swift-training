//
//  Group.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/7/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

class Group {
    private(set) var groupTitle: String!
    private(set) var groupDescription: String!
    private(set) var key: String!
    private(set) var members: [String]!
    
    init(title: String, description: String, key: String, members: [String]) {
        self.groupTitle = title
        self.groupDescription = description
        self.key = key
        self.members = members
    }
}
