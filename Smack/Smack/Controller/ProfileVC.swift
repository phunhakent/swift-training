//
//  ProfileVC.swift
//  
//
//  Created by Kent Nguyen on 10/28/17.
//

import UIKit

class ProfileVC: UIViewController {
    
    @objc func tapHandler(_ gestureRegconizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - IBAction
    @IBAction func closeModalPressed(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(sender: AnyObject) {
        UserDataService.instance.logoutUser()
        
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        userNameLbl.text = UserDataService.instance.name
        userEmailLbl.text = UserDataService.instance.email
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tapHandler(_:)))
        
        bgView.addGestureRecognizer(tapGestureRecognizer)
        
        view.backgroundColor = UIColor.clear
    }
}
