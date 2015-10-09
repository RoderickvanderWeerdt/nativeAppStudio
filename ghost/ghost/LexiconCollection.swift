// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  LexiconCollection.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 08-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation
//import UIKit

class LexiconCollection: NSObject, NSCoding {
    //var lexicon: LexiconTree
    var lexicons: Array<LexiconTree>
    let dutch: Int = 0
    let english: Int = 1
    
    init(lexicons: Array<LexiconTree>){
        self.lexicons = lexicons
    }
    
    init(type: String){
        self.lexicons = [LexiconTree](count: 2, repeatedValue: LexiconTree())
        super.init()
        if type == "test"{
            loadTest1Lexicon()
            loadTest2Lexicon()
        }
    }
    
    //lexicons are still empty
    override convenience init(){
        self.init(lexicons: [LexiconTree](count: 2, repeatedValue: LexiconTree()))
    }

    func loadDutchLexicon(){
        self.lexicons[dutch] = loadLexicon("lexicon_dutch.txt")
        print("Dutch lexicon loaded")
    }
    
    func loadTest1Lexicon(){
        self.lexicons[dutch] = loadLexicon("dutch_kopie.txt")
        print("test1 lexicon created")
    }
    
    func loadTest2Lexicon(){
        self.lexicons[english] = loadLexicon("test.txt")
        print("test2 lexicon created")
    }
    
    func loadEnglishLexicon(){
        self.lexicons[english] = loadLexicon("lexicon_english.txt")
        print("English lexicon loaded")
        
    }
    
    func loadLexicon(sourcePath: String)->LexiconTree{
        return LexiconTree(sourcePath: sourcePath)
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let lexiconsKey = "lexicons"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lexicons, forKey: PropertyKey.lexiconsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lexicons = aDecoder.decodeObjectForKey(PropertyKey.lexiconsKey) as! Array<LexiconTree>
        self.init(lexicons: lexicons)//, dutchLexicon: dutchLexicon, englishLexicon: englishLexicon)
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lexicons")
    
}