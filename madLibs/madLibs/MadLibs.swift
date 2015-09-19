//
//  MadLibs.swift
//  madLibs
//
//  Created by Roderick van der Weerdt on 18-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class MadLibs {
    //game constants
    let gameModes = ["madlib0_simple.txt", "madlib1_tarzan.txt", "madlib2_university.txt", "madlib3_clothes.txt", "madlib4_dance.txt"]
    
    //game variables
    var gameMode: String
    var gameOriginalText: String
    var gameCompleteText: String
    var gameTextWithout: Array<String>
    var gameWords: Array<String>
    var currentWord: Int = 0
    
    //gameMode between 0 and 4
    init(gameMode: Int){
        if((gameMode >= 0) && (gameMode <= 4)){
            self.gameMode = gameModes[gameMode]
        }else{
            self.gameMode = gameModes[0]
        }
        self.gameOriginalText = ""
        self.gameCompleteText = ""
        self.gameTextWithout = []
        self.gameWords = []
        getText()
        filterWords()
    }
    
    private func getText(){
        let path = NSBundle.mainBundle().pathForResource(self.gameMode, ofType: nil)
        
        var fileContents: String? = nil
        do {
            fileContents = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            print(fileContents)
            self.gameOriginalText = fileContents!
        } catch _ as NSError {
            self.gameOriginalText = "verdorie2"
        }

    }
    
    private func filterWords(){
        var currentText = ""
        for character in self.gameOriginalText.characters {
            if(character == "<"){
                self.gameTextWithout.append(currentText)
                self.gameWords.append("")
                currentText = ""
            }else if(character == ">"){
                self.gameWords.append(currentText)
                self.gameTextWithout.append("")
                currentText = ""
            }else{
                currentText.insert(character, atIndex: currentText.endIndex)
            }
        }
    }
    
    func fillInWord()->String{
        while((self.currentWord < gameWords.count) && (gameWords[self.currentWord] == "")){
            self.currentWord++
        }
        if(self.currentWord < gameWords.count){
            self.currentWord++
            return gameWords[self.currentWord-1]
        }else{
            return "All Done"
        }
    }
    
    func putInWord(newWord: String){
        self.gameWords[self.currentWord-1] = newWord
    }
    
    func composeText(){
        var i: Int = 0;
        self.gameCompleteText = ""
        while(i < self.gameTextWithout.count){
            self.gameCompleteText += self.gameTextWithout[i]+self.gameWords[i]
            i = i + 1
        }
    }

}
