//
//  ChannelCell.swift
//  Smack
//
//  Created by Kent Nguyen on 10/28/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    func configureCell(withChannel channel: Channel) {
        channelNameLbl.text = "#\(channel.title)"
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var channelNameLbl: UILabel!
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

}
