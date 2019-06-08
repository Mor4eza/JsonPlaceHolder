//
//  AppConstants.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/7/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import Foundation

struct AppConstants {
    static let mainUrl = "https://jsonplaceholder.typicode.com"
    
    //view Controllers title
    struct Titles {
        static let photosTitle = "Photos"
        static let albumsTitle = "Albums"
        static let photoDetailsTitle = "Photo Details"
    }
    
    //View Controllers identifiers
    struct VCIdentifiers {
        static let PhotosViewController = "PhotosViewController"
        static let AlbumsViewController = "AlbumsViewController"
        static let PhotoDetailsViewController = "PhotoDetailsViewController"
    }
    //Cell identifiers
    struct CellIdentifiers {
        static let photosCollectionViewCell = "PhotoCollectionViewCell"
        static let albumsTableViewCell = "AlbumTableViewCell"
    }
    
    struct Images {
        static let MediaMonksLogo = "MediaMonksLogo"
    }
}
