// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com
//
//  LexiconCollection.swift
//  ghost
//
//  The collection of lexiconTrees (currently collecting a dutch and english tree).
//  This class stores the trees and also loads the tree when the are saved or reads
//  them from a .txt file if the are not.
//

import Foundation

class LexiconCollection: NSObject, NSCoding {
    var lexicons: Array<LexiconTree>
    let dutch: Int = 0
    let english: Int = 1
    
    init(lexicons: Array<LexiconTree>){
        self.lexicons = lexicons
    }
    
    //lexicons are still empty
    override convenience init(){
        self.init(lexicons: [LexiconTree](count: 2, repeatedValue: LexiconTree()))
    }

    func loadDutchLexicon(){
        self.lexicons[dutch] = loadLexicon("lexicon_data/lexicon_dutch.txt")
        print("Dutch lexicon loaded")
    }
    
    func loadEnglishLexicon(){
        self.lexicons[english] = loadLexicon("lexicon_data/lexicon_english.txt")
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
        self.init(lexicons: lexicons)
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lexicons")
    
}