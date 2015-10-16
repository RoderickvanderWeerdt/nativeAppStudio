// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  LexiconNode.swift
//  ghost
//
//  LexiconNode are the nodes used in the trie created by LexiconTree.swift
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
    }
    
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(String(letter), forKey: PropertyKey.letterKey)
        aCoder.encodeObject(nextNodes, forKey: PropertyKey.nextNodesKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let letter = aDecoder.decodeObjectForKey(PropertyKey.letterKey) as! String
        let nextNodes = aDecoder.decodeObjectForKey(PropertyKey.nextNodesKey) as! Array<LexiconNode>
        self.init(letter: letter.characters.first!, nextNodes: nextNodes)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lexiconNode")
}