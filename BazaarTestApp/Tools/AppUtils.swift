//
//  AppUtils.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/21/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import SwiftyJSON


/**
 This class benefits from usefull functions to proviede the other classes and methods with its *Utilities*.
 ##Important##
 The functions inside the class are highly *reuseable* in all other classes
 */

class AppUtils: NSObject {
    
/**
 Its give the path of where we should save our data
     ##Important##
     1. The entery is a *name***(String)** that the function use to make the path
     2. The output is **String**
 */
    class func getPath(fileName: String) -> String {
        let fm = FileManager.default
        let docsurl = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let url = docsurl.appendingPathComponent(fileName)
        return url.path
    }
    
//    /**
//     This function interpret the *JSON* errors to *String* so they can be used easily
//     */
//    class func errorHandler(error: JSON) -> String {
//        if let err = error["status_message"].string {
//            return err
//        }
//        else if let err = error["errors"].array{
//            return err[0].stringValue
//
//        }
//        else {
//            return ""
//        }
//    }
    
    /**
     This fucntion gives the essential parameter of every request
     */
    class func getAPIKeyParam() -> [String : AnyObject]{
        var lstParams = [String : AnyObject]()
        lstParams["api_key"] = "2696829a81b1b5827d515ff121700838" as AnyObject
        return lstParams
    }
    /// This function get an ImageView and gives back a string which is the width of the image
    class func getTheWidthOfImageView(imageView : UIImageView) ->  String{
        let sizeOfImg = imageView.frame.size.width
        return "\(sizeOfImg)"
    }
    class func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

/// This Class is for getting the device related ratios
class DeviceHelper : NSObject{
    
    /// This function will give us the *width* of a device
    /// - Return :  a CGfloat which is the width
    class func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    /// This function will give us the *height* of a device
    /// - Return :  a CGfloat which is the *height*
    class func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

}
