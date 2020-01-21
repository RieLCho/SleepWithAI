//
//  ToMainViewControllerSegue.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/21.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit

class RightSegue: UIStoryboardSegue {
/*    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/3, y: 0)
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {finished in src.present(dst, animated: false, completion: nil)})
    }*/
}

class Unwind_RightSegue: UIStoryboardSegue {
/*    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/3, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {finished in src.dismiss(animated: false, completion: nil)})
    }*/
    
}
