//
//  BorderButton.swift
//  app-swoosh
//
//  Created by Kent Nguyen on 10/24/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }

}
