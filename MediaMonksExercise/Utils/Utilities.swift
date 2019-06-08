//
//  Utilities.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/7/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit
import MKProgress
class Utilites {
    
    static let shared = Utilites()
    
    func showOneButtonDialog(_ title: String, desc: String, okTitle: String, onView: UIViewController){
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default){
            _ in
            
        }
        alert.addAction(okButton)
        onView.present(alert, animated: true, completion: nil)
    }
    
    static func showProgress(){
        MKProgress.config.hudType = .radial
//        MKProgress.config.width = 64.0
//        MKProgress.config.height = 64.0
        MKProgress.config.hudColor = .white
        MKProgress.config.backgroundColor = UIColor(white: 0, alpha: 0.55)
        MKProgress.config.cornerRadius = 16.0
        MKProgress.config.fadeInAnimationDuration = 0.2
        MKProgress.config.fadeOutAnimationDuration = 0.25
        MKProgress.config.hudYOffset = 15
        MKProgress.show(true)
    }
    static func hideProgress(){
        MKProgress.hide(true)
    }
}
