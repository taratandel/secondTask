//
//  DatabaseHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/20/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import SQLite

/**
    This class Helps to connect to a *database* and keeps the data alive
    No need to open a connection every time we want to use the data base
 */

class DatabaseHelper: NSObject {
    /// **opens a Connection to a databas**
    var database: Connection!
    
    /**
     this struct keeps the database updatad so no need to fecht data eveyTime
     ## Important ##
     the reason to do this is to reduce *CPU Usage* of big APP
 */
    static let sharedDatabase: DatabaseHelper = {
    
        let instance = DatabaseHelper()
        
        let path = AppUtils.getPath(fileName: ValueKeeper.DATABASE_NAME + ".sqlite")
        instance.database = try! Connection(path)
        return instance
    }()
    
}
