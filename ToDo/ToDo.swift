//
//  ToDo.swift
//  The class for the ToDo
//  Also enabled to be saved to the memory of the phone
//
//  Created by Roderick van der Weerdt on 24-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ToDo: NSObject, NSCoding {
    
    var title: String
    var done: Bool
    
    init(title: String, done: Bool){
        self.title = title
        self.done = done
        super.init()
    }
    
    //for saving after exit
    
    // MARK: Types
    
    struct PropertyKey {
        static let titleKey = "title"
        static let doneKey = "done"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(done, forKey: PropertyKey.doneKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let done = aDecoder.decodeObjectForKey(PropertyKey.doneKey) as! Bool
        self.init(title: title, done: done)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("todos")
}
