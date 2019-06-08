//
//  Utilities.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/7/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit

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
}
