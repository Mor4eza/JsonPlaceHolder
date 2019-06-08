//
//  PhotosViewController.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/8/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    
    var photosData = [Photo]()
    var page = 0
    var loadingData = false {
        didSet {
            loadingData ? Utilites.showProgress() : Utilites.hideProgress()
        }
    }
    var allDataLoaded = false
    var albumId: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photos".uppercased()
        getPhotos(page)
       
    }
    
    func getPhotos(_ page: Int){
        loadingData = true
        Api.shared.getPhotoList(albumId: self.albumId, page: page){
            photos in
            self.loadingData = false
            if photos?.count == 0 {
                self.allDataLoaded = true
                return
            }
            self.page += 1
            for photo in photos! {
                self.photosData.append(photo)
                self.collectionView.reloadData()
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        if let url = URL(string: self.photosData[indexPath.item].thumbnailUrl) {
            cell.imgPhoto.kf.setImage(with: url)
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !loadingData && !allDataLoaded && indexPath.item == (photosData.count - 1) {
            getPhotos(page)
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as! PhotoDetailsViewController
        detailsVC.item = photosData[indexPath.item]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: UICollectionViewDelegate

    
    
}
