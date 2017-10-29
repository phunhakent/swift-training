//
//  AddChannelVC.swift
//  Smack
//
//  Created by Kent Nguyen on 10/28/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    @objc func tapHandler(_ gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var channelDescTxt: UITextField!
    @IBOutlet weak var gbView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - IBAction
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let name = channelNameTxt.text, !name.isEmpty,
            let description = channelDescTxt.text else { return }
        
        SocketService.instance.addChannel(withName: name, andDescription: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        channelDescTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        channelNameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.tapHandler(_:)))
        gbView.addGestureRecognizer(tapGestureRecognizer)
    }
}
