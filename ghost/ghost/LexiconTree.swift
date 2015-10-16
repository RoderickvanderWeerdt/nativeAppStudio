// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  LexiconTree.swift
//  ghost
//
//  LexiconTree is a trie-class, containing all the words from a lexicon. Starting at
//  the startNode which branches out the all the possible first letters of the words 
//  in the lexicon. This nodes then branch out with the letters that can be reached (given
//  the starting letter etcetera. 
//  The Class also contains a currentGameNode, a 'pointer' to the node currently used by 
//  a game (ghost for example).

import Foundation

class LexiconTree: NSCoder {
    let startNode: LexiconNode
    var currentGameNode: LexiconNode
    
    init(sourcePath: String){
        self.startNode = LexiconNode(letter: Character(" "))
        self.currentGameNode = self.startNode
        super.init()
        
        let wordArray = getWords(sourcePath)
        fillTree(wordArray)
    }
    
    init(node: LexiconNode){//for decoding from a saved LexiconTree
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
    
    //reads the words from the .txt file and returns an array of all the words to be put in the lexicon.
    private func getWords(sourcePath: String)->Array<String>{
        var allWords: Array<String> = []
        if let wordsPath = NSBundle.mainBundle().pathForResource(sourcePath, ofType: nil) {
            do {
                let words = try NSString(contentsOfFile: wordsPath, usedEncoding: nil)
                allWords = words.componentsSeparatedByString("\n")
            } catch _ {
            }
        } else {
            allWords = ["verdorie"]
        }
        return allWords
    }
    
    func moveGameNode(letter: Character){       //filter (sort of)
        for node in self.currentGameNode.nextNodes{
            if(node.letter == letter){
                self.currentGameNode = node
                break
            }
        }
    }
    
    func reset(){
        self.currentGameNode = self.startNode
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let startNodeKey = "startNodeKey"
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