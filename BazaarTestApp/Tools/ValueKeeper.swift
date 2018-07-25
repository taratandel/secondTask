//
//  ValueKeeper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/21/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import Foundation

class ValueKeeper: NSObject {
    
    /// it holds the *database name*
    static let DATABASE_NAME = "databaseOfRecentSearches"
    
    /// this is the **basic url** for all of the *requests*
    static let BASE_URL = "http://api.themoviedb.org/3"
    
    /// API SEARCH MOVIE
    static let SEARCH_MOVIE = "/search/movie"
    
    /// API Load Pic
    static let LOAD_PIC = "http://image.tmdb.org/t/p/w92"
    
}
