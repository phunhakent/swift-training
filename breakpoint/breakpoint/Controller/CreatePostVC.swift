//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    
    @IBOutlet weak var messageTv: UITextView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTv.text != nil && messageTv.text != "Say something here..." {
             sendBtn.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: messageTv.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil
                , sendComplete: { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.sendBtn.isEnabled = true
                        print("error on sending message")
                    }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailLbl.text = Auth.auth().currentUser?.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTv.delegate = self
        messageTv.bindToKeyboard()
        
        //messageTv.inputAccessoryView = sendBtn cai nay k xai dc voi view co constraint voi uiviewcontroller, set voi custom view/manual view thi ok
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
