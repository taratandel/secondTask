//
//  APIHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/21/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser
/** This class handle all the requests and their answers
 ##Important Note##
 we use **singleton** pattern in most of our classes including this one to ensure that the highly usable class wont get renewed many times
 */
class ApiHelper: NSObject {
    
    /// **Singleton** pattern impelemented in here
    static let sharedApi: ApiHelper = {
        let instance = ApiHelper()
        
        return instance
    }()
    
    func sendSimpleGetReq(urlString: String, lstParams : [String: AnyObject], onCompletion: @escaping([String:AnyObject], Bool) -> Void){
        let urlComp = NSURLComponents(string: ValueKeeper.BASE_URL + urlString)!
        
        var items = [URLQueryItem]()
        
        for (key,value) in lstParams {
            items.append(URLQueryItem(name: key, value: (String(describing: value))))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if let data = data{
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject]{
                self.checkSimpleReqStatus(json: json, onCompletion: onCompletion)
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
            
        }
        task.resume()
        
    }
    /// this function send a *get* request using *Alamofire* and parses the answer no matter it is JSON or XML
    func sendGetRequest(urlString: String, lstParams:
        [String: AnyObject], onCompletion: @escaping([String:AnyObject], Bool) -> Void) {

        let url = ValueKeeper.BASE_URL + urlString
        _ = Alamofire.request(url, method: .get, parameters: lstParams, encoding: URLEncoding.default, headers: nil).responseData {
            response in
            switch response.result{
            case .success(let value):
                
                if let json = try? JSON(data: value)  {
                    if json.type == SwiftyJSON.Type.dictionary {
                        self.checkStatus(json: json, onCompletion: onCompletion)
                    }
    
                }
               
                else {
                     let xml = XML.parse(value)
                        self.checkXMLStatus(xml: xml, onCompletion: onCompletion)
                }
            case .failure(let error):
                onCompletion(["error":error as AnyObject], false)
            }
        }
        
    }
    
    /**
     This function check the status of the answer provided
     - Parameter json: Json Data Provided .
     - Parameter onCompletion: a status which is Boolian and the parsed data whether it is an error or not.
     */
    
    func checkStatus(json: JSON, onCompletion: ([String:AnyObject], Bool) -> Void) {
        let pageCount = json["total_pages"].int
        if pageCount != nil {
            if pageCount! > 0{
            onCompletion(json.dictionary! as [String : AnyObject], true)
            }
            else {
                onCompletion(["error":"query wrong" as AnyObject], false)
            }
        } else if json["errors"] != JSON.null{
            onCompletion(["error":json["errors"].array as AnyObject], false)
        }
        else {
            
        }
    }
    func checkSimpleReqStatus (json: [String: AnyObject], onCompletion: ([String:AnyObject], Bool) -> Void){
        if let pageCount = json["total_pages"] as? Int{
            if pageCount > 0 {

                onCompletion(json, true)
            }
            else {
                onCompletion(["error":"query wrong" as AnyObject], false)
            }

            
        }
        else if json["errors"] != nil{
            onCompletion(["error":json["errors"] as AnyObject], false)
        }
    }
    
    /**
     This function checkes the status of the XML response if we have an HTML Tag its and error other wise base on the answer we act
     */
    func checkXMLStatus(xml : XML.Accessor, onCompletion: ([String:AnyObject], Bool)-> Void){
        
        if xml["HTML"].error == nil || xml["html"].error == nil{
            onCompletion(["error" : "Must use Anti Filter" as AnyObject] ,false)
        }
        else {
            onCompletion(["error":"must parse the xml" as AnyObject], false)
        }
        
        
    }
    
    
}
