//
//  MessageCell.swift
//  Smack
//
//  Created by Kent Nguyen on 10/29/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    func configureCell(message: Message) {
        contentLbl.text = message.content
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var userImg: CircleImage!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } 
}
