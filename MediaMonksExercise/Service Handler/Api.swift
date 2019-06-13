//
//  Api.swift
//  MediaMonksExercise
//
//  Created by Morteza on 6/7/19.
//  Copyright © 2019 Morteza. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    static let shared = Api()
    
    
    /// requset method
    ///
    /// - Parameters:
    ///   - method: make requst with Alamofire
    ///   - uri: url path
    ///   - parameters: parameters
    /// - Returns: return DataRequest
    fileprivate func request(method: Alamofire.HTTPMethod, uri: String, parameters: [String : Any]? = nil) -> DataRequest {
        
        let url = URL(string: AppConstants.mainUrl + uri)!
        let request = Alamofire.request(url, method: method, parameters: parameters)
        
        request.responseData { dataResponse in
            if let error = dataResponse.result.error as NSError?, error.code == -1009 {
                if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                    Utilites.hideProgress()
                    Utilites.shared.showOneButtonDialog("Error", desc: "No Internet Connection", okTitle: "Retry", onView: rootController)
                }
            } else {
                if let statusCode = dataResponse.response?.statusCode {
                    switch statusCode {
                    case 403:
                        Utilites.hideProgress()
                        print("403 - forbidden")
                    case 404:
                        Utilites.hideProgress()
                        print("404 - not found")
                    case 500:
                        Utilites.hideProgress()
                        print("500 - no response")
                    default:
                        break
                    }
                }
            }
        }
        return request
    }
    
    
    /// function to make get calls
    ///
    /// - Parameters:
    ///   - uri: url path
    ///   - parameters: parameters
    /// - Returns: return the data requst for json encoding
    fileprivate func get(_ uri: String,parameters: [String: Any]? = nil) -> DataRequest {
        return request(method: .get, uri: uri, parameters: parameters)
    }
    
    
    /// function to make post calls
    ///
    /// - Parameters:
    ///   - uri: url path
    ///   - parameters: parameters
    /// - Returns: return the data requst for json encoding
    fileprivate func post(_ uri: String,
                          parameters: [String: Any]? = nil) -> DataRequest {
        return request(method: .post, uri: uri, parameters: parameters)
    }
    
    
    /// get albums from server
    ///
    /// - Parameter completionHandler: album list
    func getAlbumList(page: Int, _ completionHandler: @escaping ([Album]?) -> Void){
        
        let parameters = ["_limit": 15,
                          "_page": page]
        
        let req = get("/albums",parameters: parameters)
        
        req.responseJSON { response in
            
            guard let json = response.data else {
                completionHandler(nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                let albums = try decoder.decode([Album].self, from: json)
                completionHandler(albums)
            }catch let err{
                print(err)
            }
        }
    }
    
    
    
    /// get Photos Data
    ///
    /// - Parameters:
    ///   - albumId: album id
    ///   - page: current page
    ///   - completionHandler: return the data request
    func getPhotoList(albumId: Int ,page: Int, _ completionHandler: @escaping ([Photo]?) -> Void){
        
        let parameters = ["_limit": 15,
                          "_page": page]
        
        let req = get("/albums/\(albumId)/photos",parameters: parameters)
        
        req.responseJSON { response in
            
            guard let json = response.data else {
                completionHandler(nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                let photos = try decoder.decode([Photo].self, from: json)
                completionHandler(photos)
            }catch let err{
                print(err)
            }
        }
        
        
    }
    
}
