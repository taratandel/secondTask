//
//  ViewHelper.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/22/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import LinearProgressBarMaterial

/// This class handles the view related actions
class ViewHelper: NSObject {
    
 /// shows Toast Message, view independent
class func showToastMessage(message: String) {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let holder = UIView(frame: CGRect.zero)
    let label = UILabel(frame: CGRect.zero)
    label.textAlignment = NSTextAlignment.center
    label.text = message
    label.font = UIFont(name: "Helvetica", size: 13)
    label.adjustsFontSizeToFitWidth = true
    holder.backgroundColor = UIColor.black
    label.backgroundColor = UIColor.black
    label.textColor = UIColor.white
    label.sizeToFit()
    label.numberOfLines = 4
    label.layer.shadowColor = UIColor.gray.cgColor
    label.layer.shadowOffset = CGSize(width: 4, height: 3)
    label.layer.shadowOpacity = 0.3
    
    holder.frame = CGRect(x: 0, y: -64, width: appDelegate.window!.frame.size.width, height: 64)
    label.frame = CGRect(x: 0, y: 20, width: appDelegate.window!.frame.size.width, height: 44)
    
    label.alpha = 1
    holder.addSubview(label)
    appDelegate.window!.addSubview(holder)
    
    var topFrame = holder.frame
    topFrame.origin.y = 0
    
    UIView.animate(withDuration
        : 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            holder.frame = topFrame
    }, completion: {
        (value: Bool) in
        UIView.animate(withDuration: 1.0, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            holder.frame = CGRect(x: 0, y: -64, width: appDelegate.window!.frame.size.width, height: 64)
        }, completion: {
            (value: Bool) in
            holder.removeFromSuperview()
        })
    })
}
    /// This function will create a progress bar using the *LinearProgressBarMaterial*
    class func createPrimaryLinearProgress(frame: CGRect) -> LinearProgressBar {
        let progress = LinearProgressBar(frame: frame)
        progress.progressBarColor = .gray
        progress.backgroundProgressBarColor = .darkGray
        progress.startAnimation()
        progress.heightForLinearBar = 3
        return progress
    }
}
