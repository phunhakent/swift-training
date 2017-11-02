//
//  UIViewControllerExt.swift
//  goal-post
//
//  Created by Kent Nguyen on 11/2/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        // if set animated = true => default animation is used
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        guard let presentedViewController = self.presentedViewController else {
            return
        }
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail() {
        let transition = CATransition()
        
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        // if set animated = true => default animation is used
        dismiss(animated: false, completion: nil)
    }
}
