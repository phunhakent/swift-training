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
        
        guard var isoDate = message.timestamp else { return }
        
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate[..<end].appending("Z")
        
        
        let newFormatter = DateFormatter()
//        newFormatter.dateStyle = .none
//        newFormatter.timeStyle = .short
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        let isoFormatter = ISO8601DateFormatter()
        if let chatDate = isoFormatter.date(from: isoDate) {
            timeLbl.text = newFormatter.string(from: chatDate)
        }
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
