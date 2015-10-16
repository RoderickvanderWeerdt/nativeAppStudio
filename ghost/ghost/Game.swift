// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  Game.swift
//  ghost
//
//  This is the class in which the game of ghost takes place. It takes a lexicon
//  which it uses to create a word (through the use of a wordFragment) which it will
//  do until the wordFragment consists of a whole word, which finishes the game.
//  player1 always starts.

import UIKit

class Game: NSObject{
    let lexicon: LexiconTree
    let player1: Player
    let player2: Player
    
    var wordFragment: String
    
    init(lexicon: LexiconTree, player1: Player, player2: Player, wordFragment: String){
        self.lexicon = lexicon
        self.player1 = player1
        self.player2 = player2
        self.wordFragment = wordFragment
        self.lexicon.reset()

    }
    
    convenience init(lexicon: LexiconTree, player1: Player, player2: Player){
        self.init(lexicon: lexicon, player1: player1, player2: player2, wordFragment: "")
    }
    
    convenience init(gameState: GhostGameState, lexicon: LexiconTree, player1: Player, player2: Player){
        self.init(lexicon: lexicon, player1: player1, player2: player2, wordFragment: gameState.wordFragment)
        for letter in self.wordFragment.characters{
            lexicon.moveGameNode(letter)
        }
    }

    
    convenience override init(){
        self.init(lexicon: LexiconTree(), player1: Player(), player2: Player(), wordFragment: "")
    }
    
    //this method takes a string as input, representing the letter that the 
    //current player has guessed. It uses the Lexicon instance to decide
    func guess(guess: Character)->Bool{
        print(playerTurn().name+" guesses " + String(guess))
        let possibleNodes = lexicon.currentGameNode.returnNextNodes()
        if possibleNodes.contains(guess){
            print("good Guess!")
            self.wordFragment += String(guess)
            lexicon.moveGameNode(guess)
            return true
        }else{
            print("wrong Guess!")
            return false
        }
    }
    
    //this method returns a boolean indicating which player is up for guessing.
    //true for player1, false for player2
    func player1Turn()->Bool{
        if(wordFragment.characters.count % 2 == 0){ //if even number player1turn
            return true
        }else{
            return false
        }
    }
    
    func playerTurn()->Player{
        if(player1Turn()){
            return self.player1
        }else{
            return self.player2
        }
    }
    
    //this method returns a boolean indicating if the game has ended.
    func ended()->Bool{
        if(self.lexicon.currentGameNode.hasNextNodeWithLetter(".") && (self.wordFragment.characters.count > 3)){
            return true
        }else{
            return false
        }
        
    }
    
    //this method returns a boolean indicating which player has won the game. 
    //This method can obviously only make sense if ended returns true.
    func winner()->Player{
        if ended(){
            if player1Turn(){
                return self.player1
            }else{
                return self.player2
            }
        }
        return Player()
    }
    
    func loser()->Player{
        if ended(){
            if !player1Turn(){
                return self.player1
            }else{
                return self.player2
            }
        }
        return Player()
    }
    
    func possibilities()->Array<Character>{
        return lexicon.currentGameNode.returnNextNodes()
    }
    
    func reset(){
        self.lexicon.reset()
        self.wordFragment = ""
    }
}
