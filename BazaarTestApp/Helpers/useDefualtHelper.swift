//
//  useDefualtHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 5/3/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import Foundation

class SaveWithUserDef: NSObject {
    func saveData (searchItem : Search) {
        let key = searchItem.title
    let data = NSKeyedArchiver.archivedData(withRootObject: searchItem.title)
    UserDefaults.standard.set(data, forKey: key)
    }
    
    func retrive() -> [Search]{
        
         let data = UserDefaults.standard.stringArray(forKey: "SavedStringArray") ?? [String]()
        var lstSearch = [Search]()
        for searchItems in data{
            let searchItem = Search()
            searchItem.title = searchItems
            lstSearch.append(searchItem)
        }
        return lstSearch
    }
    func removeUserDefualt(searchItem: Search){
        UserDefaults.standard.removeObject(forKey: searchItem.title)
    }
    func addOrUpdateUserDefault(searchItem : Search){
        let searches =  self.retrive()
        if  (searches.count) > 9 {
            self.removeUserDefualt(searchItem: searches[0])
        }
        self.saveData(searchItem: searchItem)
    }
}
