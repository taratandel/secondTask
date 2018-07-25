//
//  CoreDataHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/24/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import Foundation
import CoreData
import UIKit
/**
 This class if for managing core data it saves the data and fetches them
 ##Important Note##
 This class in implemented but not used yet it can be used on demand
 */
class CoreDataCalcs {
    /// only availble from *iOS 10 or higher*
    /// fetches all the data saved in core data
    @available(iOS 10.0, *)
    func fetchFromCoreDate() -> [Search]?{
        var useDatas = [NSManagedObject]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetching Datas
        
        let fechtRequest  = NSFetchRequest<NSManagedObject>(entityName: "SearchItems")
        
        //check if data exists or not
        do {
            //if exists fill the array
            useDatas = try managedContext.fetch(fechtRequest)
            var searchItems = [Search]()
            if useDatas.count > 0 {
                for item in useDatas {
                    let searchItem = Search()
                    searchItem.title = item.value(forKey: "title") as! String
                    searchItems.append(searchItem)
                }
                return searchItems
            }
            else {
                return nil
            }
        }
        catch let error as NSError {
            //if not shows the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
        
    }
    /// save a single item in core data
    /// - parameter info: search item to be saved in core data
    /// - Return: a boolian value which shows the success if saving
    @available(iOS 10.0, *)
    func saveToCoreData(info : Search) -> Bool{
        var useDatas = [NSManagedObject]()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName:"SearchItems",
                                       in: managedContext)!
        
        let search = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        search.setValue(info.title , forKeyPath: "title")
        
        do {
            try managedContext.save()
            useDatas.append(search)
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        
    }
    
    /// deletes a single item from core data
    @available(iOS 10.0, *)
    func deleteSingleFromCoreData(searches : Search){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //fetching Datas
            
            let fechtRequest  = NSFetchRequest<NSManagedObject>(entityName: "SearchItems")
            
            let predicate = NSPredicate(format: "title = %@", searches.title)
            
            fechtRequest.predicate = predicate
            do{
                let result = try managedContext.fetch(fechtRequest)
                
                if result.count > 0{
                    for object in result {
                        print(object)
                        managedContext.delete(object )
                    }
                }
            }catch{
                print("item did not delete")
            }
        
    }
    
    /// delete all from coredata
    @available(iOS 10.0, *)
    func deleteAllFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //fetching Datas
        
        let fechtRequest  = NSFetchRequest<NSManagedObject>(entityName: "SearchItems")
        
        //check if data exists or not
        do {
            //if exists fill the array
            let nationalCode = try managedContext.fetch(fechtRequest)
            for managedObject in nationalCode
            {
                let managedObjectData:NSManagedObject = managedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in IsLoggedIn error : \(error) \(error.userInfo)")
        }
    }
    
    /// this function only can interact with outside of the class. it checkes on the count of saved objects and if a data is duplicated it wil replace it
    @available(iOS 10.0, *)
    func addOrUpdateCoreDate(searchItem : Search) -> Bool{
        let searches =  self.fetchFromCoreDate()
        if searches != nil && (searches?.count)! > 9 {
            self.deleteSingleFromCoreData(searches: searches![0])
        }
        return self.saveToCoreData(info: searchItem)
    }
    
    
}
