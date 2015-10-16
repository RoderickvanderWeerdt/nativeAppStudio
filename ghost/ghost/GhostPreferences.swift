// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015

//
//  GhostPreferences.swift
//  ghost
//
//  GhostPreferences is used to keep track (and save) the preferences of the user.
//  Preferences of the user include the names of the players, a list of all the 
//  previous players and the currentLexicon being used for the game.
//

import UIKit

class GhostPreferences: NSObject, NSCoding {
    //default
    let dutch: Int = 0
    let english: Int = 1
    
    //for self
    var player1: Player
    var player2: Player
    var currentLexicon: Int
    var players: Array<Player>
    
    init(player1: Player, player2: Player, players: Array<Player>, currentLexicon: Int){
        self.player1 = player1
        self.player2 = player2
        self.players = players
        self.currentLexicon = currentLexicon
        super.init()
    }
    
    //Default lexicon is dutch
    override convenience init(){
        self.init(player1: Player(), player2: Player(), players: [], currentLexicon: 0)     //zero beetje hardcoded
    }
    
    func useLexicon(language: Int){
        self.currentLexicon = language
        print("self.currentLexicon = " + String(self.currentLexicon))
    }
    
    func addPlayers(){
        var player1found = false
        var player2found = false
        for player in self.players{
            if((player1found == false) && (player.name == player1.name)){
                self.player1 = player
                player1found = true
                print(player.name + " found")
            }else if((player2found == false) && (player.name == player2.name)){
                self.player2 = player
                player2found = true
                print(player.name + " found")
            }
        }
        if(!player1found){
            print("new player in town: '" + self.player1.name + "'")
            self.players.append(self.player1)
        }
        if(!player2found){
            print("new player in town: '" + self.player2.name + "'")
            self.players.append(player2)
        }
    }
    
    
    // MARK: Types
    struct PropertyKey {
        static let player1Key = "player1"
        static let player2Key = "player2"
        static let playersKey = "players"
        static let currentLexiconKey = "currentLexicon"
    }
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(player1, forKey: PropertyKey.player1Key)
        aCoder.encodeObject(player2, forKey: PropertyKey.player2Key)
        aCoder.encodeObject(players, forKey: PropertyKey.playersKey)
        aCoder.encodeObject(currentLexicon, forKey: PropertyKey.currentLexiconKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let player1 = aDecoder.decodeObjectForKey(PropertyKey.player1Key) as! Player
        let player2 = aDecoder.decodeObjectForKey(PropertyKey.player2Key) as! Player
        let players = aDecoder.decodeObjectForKey(PropertyKey.playersKey) as! Array<Player>
        let currentLexicon = aDecoder.decodeObjectForKey(PropertyKey.currentLexiconKey) as! Int
        self.init(player1: player1, player2: player2, players: players, currentLexicon: currentLexicon)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("preferences")

}