//
//  File.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/20/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyXMLParser

/// This class holds Movie model which is provided by the API and does the model related functions
class Movie : NSObject, NSCoding{
    
    /// *id* of the *Movie*
    var id = 0
    /// *title* of the *Movie*
    var title = ""
    /// *posterPatch* of the *Movie*
    var posterPatch = ""
    /// *releaseDate* of the *Movie*
    var releaseDate = ""
    /// *overview* of the *Movie*
    var overview = ""
    
    override init() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.posterPatch = aDecoder.decodeObject(forKey: "posterPatch") as! String
        self.releaseDate = aDecoder.decodeObject(forKey: "releaseDate") as! String
        self.overview = aDecoder.decodeObject(forKey: "overview") as! String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.title, forKey: "id")
        aCoder.encode(self.posterPatch, forKey: "posterPatch")
        aCoder.encode(self.releaseDate, forKey: "releaseDate")
        aCoder.encode(self.overview, forKey: "overview")

    }

    /**
     The function takes in a **JSON** and gives back a *Movie* model
     */
    class func buildSingle(data : JSON) -> Movie {
        let movie = Movie()
        movie.id = data["id"].intValue
        movie.overview = data["overview"].stringValue
        movie.posterPatch = data["poster_path"].stringValue
        movie.releaseDate = data["release_date"].stringValue
        movie.title = data["title"].stringValue
        return movie
        
    }
    class func buildSimple(data : [String : AnyObject]) -> Movie {
        let movie = Movie()
        if let  id = data["id"] as? Int{
            movie.id = id
        }
            
        else {
            return movie
        }
        if let overview = data["overview"] as? String{
            movie.overview = overview
        }
        else {
            return movie
        }
        if let posterPatch = data["poster_path"] as? String{
            movie.posterPatch = posterPatch
        }
        else {
            return movie
        }
        if let releaseDate = data["release_date"] as? String{
            movie.releaseDate = releaseDate
        }
        else {
            return movie
        }
        if let title = data["title"] as? String{
            movie.title = title
        }
        else {
                return movie
        }
        return movie
    }
    class func buildSimpleList(data : Array<[String : AnyObject]> )-> [Movie] {
        var movies = [Movie]()
        for index in 0..<data.count {
            movies.append(Movie.buildSimple(data: data[index]))
        }
        return movies
    }
    /// this function buld a list of *Movie* with **JSON**
    class func buildList(data : JSON) -> [Movie]{
        var movies = [Movie]()
        for index in 0..<data.count{
            movies.append(Movie.buildSingle(data: data[index]))
        }
        return movies
        
    }
   
    /**
     The function takes in a **XML** and gives back a *Movie* model
     */
    class func buildXMLSingle(data : XML.Accessor) -> Movie {
        let movie = Movie()
        
        return movie
        
    }
    
    /// this function buld a list of *Movie* with **XML** data
    class func buildXMLList(data : JSON) -> [Movie]{
        let movies = [Movie]()

        return movies
        
    }
    
}
