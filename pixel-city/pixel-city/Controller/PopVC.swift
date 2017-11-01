//
//  PopVC.swift
//  pixel-city
//
//  Created by Kent Nguyen on 11/1/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    var passedImage: UIImage!
    
    func initData(forImage image: UIImage) {
        self.passedImage = image;
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(PopVC.doubleTapHandler(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func doubleTapHandler(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var popImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popImageView.image = passedImage
        
        addDoubleTap()
    }
}
