
//
//  CircleView.swift
//  Smack
//
//  Created by Kent Nguyen on 10/27/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

}
