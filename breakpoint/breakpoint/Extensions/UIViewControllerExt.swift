//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/7/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
