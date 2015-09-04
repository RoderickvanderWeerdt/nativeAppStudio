//
//  UIAlertController+Convenience.swift
//  Vehicles
//
//  Created by Roderick van der Weerdt on 03-09-15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func alertControllerWithTitle(title:String, message:String) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        return controller
    }
    
    class func alertControllerWithNumberInput(#title:String, message:String, buttonTitle:String, handler:(Int?)->Void) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        controller.addTextFieldWithConfigurationHandler { $0.keyboardType = .NumberPad }
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        controller.addAction(UIAlertAction(title: buttonTitle, style: .Default) { action in
            let textFields = controller.textFields as? [UITextField]
            let value = textFields?[0].text.toInt()
            handler(value)
            } )
        
        return controller
    }
}