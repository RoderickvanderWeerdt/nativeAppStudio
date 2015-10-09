// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  GhostGameState.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 10-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class GhostGameState: NSObject, NSCoding {
    
    var player1: Player
    var player2: Player
    var wordFragment: String
    var finished: Bool
    var language: Int
    
    init(player1: Player, player2: Player, wordFragment: String, language: Int, finished: Bool){
        self.player1 = player1
        self.player2 = player2
        self.wordFragment = wordFragment
        self.language = language
        self.finished = finished
    }
    
    convenience override init(){
        self.init(player1: Player(), player2: Player(), wordFragment: "", language: 0, finished: true)
    }
    
    // MARK: Types
    struct PropertyKey {
        static let player1Key = "player1"
        static let player2Key = "player2"
        static let wordFragmentKey = "wordFragment"
        static let finishedKey = "finished"
        static let languageKey = "language"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(player1, forKey: PropertyKey.player1Key)
        aCoder.encodeObject(player2, forKey: PropertyKey.player2Key)
        aCoder.encodeObject(wordFragment, forKey: PropertyKey.wordFragmentKey)
        aCoder.encodeObject(finished, forKey: PropertyKey.finishedKey)
        aCoder.encodeObject(language, forKey: PropertyKey.languageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let player1 = aDecoder.decodeObjectForKey(PropertyKey.player1Key) as! Player
        let player2 = aDecoder.decodeObjectForKey(PropertyKey.player2Key) as! Player
        let wordFragment = aDecoder.decodeObjectForKey(PropertyKey.wordFragmentKey) as! String
        let finished = aDecoder.decodeObjectForKey(PropertyKey.finishedKey) as! Bool
        let language = aDecoder.decodeObjectForKey(PropertyKey.languageKey) as! Int
        self.init(player1: player1, player2: player2, wordFragment: wordFragment, language: language, finished: finished)
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("game")
    
    

}