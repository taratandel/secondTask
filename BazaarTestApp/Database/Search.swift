//
//  Search.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/21/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import Foundation
import SQLite
import CoreData
/// This class holds a search model which includes the title user writes in textfield
class Search: NSObject {
    
    /// Name of the table to store in the database
    static let TABLE_NAME = "Search"
    /// "id" of the searched term which increment one by one
//    var id = 0
    /// the searched term
    var title = ""
    
    /// *ID* Expression to use with *SQLite* Library
//    static let ID = Expression<Int64>("id")
    /// *TITLE* Expression to use with *SQLite* Library
    static let TITLE = Expression<String>("title")
    
    /// This function builds a row in the database and returns a *Search* model
    class func buildDataBaseRow(row : Row) -> Search {
        let search = Search()
//        search.id = Int(row[ID])
        search.title = String(row[TITLE])

        return search
    }
    
    /// This will build multiple rows on the database
    class func buildDatabaseList(list: AnySequence<Row>) -> [Search] {
        var lstSearch = [Search]()
        for data in list {
            lstSearch.append(buildDataBaseRow(row: data))
        }
        return lstSearch
    }
    
}
