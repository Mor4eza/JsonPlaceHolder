//
//  PhotoDetailsViewController.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/8/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var tvDetails: UITextView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    var item: Photo!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isSwipable()
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 10.0
        imageScrollView.delegate = self
        self.title = AppConstants.Titles.photoDetailsTitle.uppercased()
        if let imageURL = URL(string: item.url) {
            imgPhoto.kf.indicatorType = .activity
            imgPhoto.kf.setImage(with: imageURL)
        }
        tvDetails.text = item.title
        
//        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
        
    }
    
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgPhoto
    }

}
