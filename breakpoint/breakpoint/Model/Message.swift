//
//  Message.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

class Message {
    private(set) var content: String
    private(set) var senderId: String
    
    init(content: String, senderId: String) {
        self.content = content
        self.senderId = senderId
    }
}
