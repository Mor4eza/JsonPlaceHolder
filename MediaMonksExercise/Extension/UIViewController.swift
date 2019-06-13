//
//  UIViewController.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/13/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit

// MARK: EXTENSION
extension UIViewController {
    
    // MARK: IS SWIPABLE - FUNCTION
    func isSwipable() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: HANDLE PAN GESTURE - FUNCTION
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        let touchPoint = panGesture.location(in: view?.window)
        var initialTouchPoint = CGPoint.zero
        
        
        if panGesture.state == .began {
            initialTouchPoint = touchPoint
        } else if panGesture.state == .changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if panGesture.state == .ended || panGesture.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
}
