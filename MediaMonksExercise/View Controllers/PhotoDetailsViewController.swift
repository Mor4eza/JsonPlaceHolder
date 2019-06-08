//
//  PhotoDetailsViewController.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/8/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    
    @IBOutlet weak var tvDetails: UITextView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    var item: Photo!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photo Details".uppercased()
        if let imageURL = URL(string: item.url) {
            imgPhoto.kf.setImage(with: imageURL)
        }
        tvDetails.text = item.title
        
    }
    
 

}
