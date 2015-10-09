// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  LexiconNode.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class LexiconNode: NSCoder{
    let letter: Character
    var nextNodes: Array<LexiconNode>
    
    

    
    init(letter: Character, nextNodes: Array<LexiconNode>){
        self.letter = letter
        self.nextNodes = nextNodes
        super.init()
    }
    
    convenience init(letter: Character){
        self.init(letter: letter, nextNodes: [])
    }

    override convenience init(){
        //self.letter = letter
        //self.nextNodes = []
        self.init(letter: " ", nextNodes: [])
    }
    
    func addNextNode(nextNode: LexiconNode){
        self.nextNodes.append(nextNode)
    }
    
    func hasNextNodeWithLetter(letter: Character)->Bool{
        for node in self.nextNodes{
            if(node.letter == letter){
                return true
            }
        }
        return false
    }
    
    func getNextNodeWithLetter(letter: Character)->LexiconNode{
        for node in self.nextNodes{
            if(node.letter == letter){
                return node
            }
        }
        print("ERROR, couldn't find next node!")
        return self
    }
    
    func printNextNodes(){
        for node in nextNodes{
            print("("+String(node.letter))
            node.printNextNodes()
            print(")")
        }
    }
    
    func printOptions(){
        print("start printing reachable Nodes")
        var optionNodes: Array<Character> = []
        for node in self.nextNodes{
            optionNodes.append(node.letter)
        }
        print(optionNodes)
    }
    
    func returnNextNodes()->Array<Character>{
        var optionNodes: Array<Character> = []
        for node in self.nextNodes{
            optionNodes.append(node.letter)
        }
        return optionNodes
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let letterKey = "letterKey"
        static let nextNodesKey = "nextNodesKey"
        //static let winsKey = "wins"
    }
    
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(String(letter), forKey: PropertyKey.letterKey)
        aCoder.encodeObject(nextNodes, forKey: PropertyKey.nextNodesKey)
        //aCoder.encodeObject(currentNode, forKey: PropertyKey.winsKey) //for continuing in game after end
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let letter = aDecoder.decodeObjectForKey(PropertyKey.letterKey) as! String
        let nextNodes = aDecoder.decodeObjectForKey(PropertyKey.nextNodesKey) as! Array<LexiconNode>
        //let wins = aDecoder.decodeObjectForKey(PropertyKey.winsKey) as! Int
        self.init(letter: letter.characters.first!, nextNodes: nextNodes)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lexiconNode")
}