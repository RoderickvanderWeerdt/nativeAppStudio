// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  LexiconTree.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class LexiconTree: NSCoder {
    let startNode: LexiconNode
    var currentGameNode: LexiconNode
    
    init(sourcePath: String){
        self.startNode = LexiconNode(letter: Character(" "))
        self.currentGameNode = self.startNode
        super.init()
        
        let wordArray = getWords(getText(sourcePath))
        fillTree(wordArray)
    }
    
    init(node: LexiconNode){        //for decoding
        self.startNode = node
        self.currentGameNode = self.startNode
    }
    
    override convenience init() {
        self.init(node: LexiconNode(letter: " "))
    }
    
    func fillTree(wordArray: Array<String>){
        var currentNode = self.startNode
        var nodeDepth = 0
        
        for word in wordArray{
            
            for character in word.characters{
                if((currentNode.hasNextNodeWithLetter(".")) && (nodeDepth > 3)){
                    break   //don't add words which start with another word
                }else if(currentNode.hasNextNodeWithLetter(character)){
                    currentNode = currentNode.getNextNodeWithLetter(character)
                }else{
                    currentNode.addNextNode(LexiconNode(letter: character))
                    currentNode = currentNode.getNextNodeWithLetter(character)
                }
                nodeDepth++
            }
            currentNode.addNextNode(LexiconNode(letter: "."))   //closing node
            currentNode = self.startNode
            nodeDepth = 0
        }
    }
    
    private func getText(sourcePath: String) -> String{
        
        let path = NSBundle.mainBundle().pathForResource(sourcePath, ofType: nil)
        var fileContents: String? = nil
        do{
            fileContents = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            return fileContents!
        }catch _ as NSError{
            print("darn!, file reading error")
            return "verdorie"
        }
        
    }
    
    private func getWords(originalText: String)->Array<String>{
        var wordString: Array<String> = []
        var currentText: String = ""
        for character in originalText.characters {
            if(character == "\n"){
                wordString.append(currentText)
                currentText = ""
            }else{
                currentText.insert(character, atIndex: currentText.endIndex)
            }
        }
        wordString.append(currentText)   //last word
        return wordString
    }
    
    func moveGameNode(letter: Character){       //filter (sort of)
        for node in self.currentGameNode.nextNodes{
            if(node.letter == letter){
                self.currentGameNode = node
                break
            }
        }
    }
    
    func count()->Int{      //sort of
        return self.currentGameNode.nextNodes.count
    }
    
    func reset(){
        self.currentGameNode = self.startNode
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let startNodeKey = "startNodeKey"
        //static let winsKey = "wins"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(startNode, forKey: PropertyKey.startNodeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let startNode = aDecoder.decodeObjectForKey(PropertyKey.startNodeKey) as! LexiconNode
        self.init(node: startNode)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lexiconTree")
    
    
}