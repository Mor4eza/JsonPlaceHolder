//
//  AlbumsViewController.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/8/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import UIKit
class AlbumsViewController: UITableViewController {

    var albumData = [Album]()
    var page = 0
    var loadingData = false
    var allDataLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilites.showProgress()
        self.title = "Albums".uppercased()
        getAlbums(page)
       
    }

    // MARK: - Call Api Function
    
    func getAlbums(_ page: Int){
        loadingData = true
        Api.shared.getAlbumList(page: page){
            albums in
            Utilites.hideProgress()
            self.loadingData = false
            if albums?.count == 0 {
                self.allDataLoaded = true
                return
            }
            self.page += 1
            for album in albums! {
                self.albumData.append(album)
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell

        if let title =  self.albumData[indexPath.row].title {
            cell.lblTitle.text = title
        }
            
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !loadingData && !allDataLoaded && indexPath.row == (albumData.count - 1) {
            getAlbums(page)
            
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
            }
        }else {
            self.tableView.tableFooterView = UIView()
            self.tableView.tableFooterView?.isHidden = true
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        photosVC.albumId = self.albumData[indexPath.row].id
        self.navigationController?.pushViewController(photosVC, animated: true)
    }

    
}
