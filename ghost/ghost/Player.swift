// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  Player.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding{
    let name: String
    var wins: Int
    
    
    init(playerName: String, wins: Int){
        self.name = playerName
        self.wins = wins
    }
    
    convenience init(playerName: String){
        self.init(playerName: playerName, wins: 0)
    }
    
    override convenience init(){
        self.init(playerName: "", wins: 0)
    }
    
    func victory(){
        self.wins++
    }
    
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let winsKey = "wins"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(wins, forKey: PropertyKey.winsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let wins = aDecoder.decodeObjectForKey(PropertyKey.winsKey) as! Int
        self.init(playerName: name, wins: wins)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("players")

    
}