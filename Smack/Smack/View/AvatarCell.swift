//
//  AvatarCell.swift
//  Smack
//
//  Created by Kent Nguyen on 10/27/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

enum AvatarType: Int {
    case dark = 0
    case light = 1
}

class AvatarCell: UICollectionViewCell {
    func setupView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func configureCell(forIndex index: Int, withType type: AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
}
