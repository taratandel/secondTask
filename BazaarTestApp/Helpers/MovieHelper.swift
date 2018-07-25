//
//  MovieHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/22/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import SwiftyJSON

/// This protocol is for having connection between our helpers and view
/// This protocol benefits from 2 function
/// These functions consider the situation of the given answer
@objc protocol MovieDelegate: NSObjectProtocol{
    @objc optional func getMovieSuccessfuly(lstMoviev: [Movie], pageNumber : Int)
    @objc optional func failedToGetMovie(error : String)
}
/// This class handles the *Movie* related functions
class MovieHelper: NSObject {
    
    var delegate: MovieDelegate!
    
    
    /// This function has 2 parameter, it will request using these parameters and pass the data to a protocol method.
    /// - parameter page: Int value specifying the page number
    /// - parameter query: String which the user is searching for
    
    func getMovies(page : Int, query : String){
        var lstParams = AppUtils.getAPIKeyParam()
        lstParams["page"] = page as AnyObject
        lstParams["query"] = query as AnyObject
        ApiHelper.sharedApi.sendSimpleGetReq(urlString: ValueKeeper.SEARCH_MOVIE, lstParams: lstParams){
            response, status in
            if status {
                var lstMovies = [Movie]()
                var pageNO = 0
                if let pages = response["total_pages"] as? Int {
                     pageNO = pages
                }
                else {
                     pageNO = 0
                }
                
                lstMovies = (Movie.buildSimpleList(data: response["results"] as! Array<[String: AnyObject]>))
                
                if self.delegate.responds(to: #selector(MovieDelegate.getMovieSuccessfuly(lstMoviev: pageNumber:))) {
                    self.delegate.getMovieSuccessfuly!(lstMoviev: lstMovies, pageNumber: pageNO)
                }
            } else {
                if self.delegate.responds(to: #selector(MovieDelegate.failedToGetMovie(error:))) {
                    self.delegate.failedToGetMovie!(error: String(describing: response["error"]) )
                }
            }
        }
    }
}
