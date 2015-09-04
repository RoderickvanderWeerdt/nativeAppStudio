//
//  RandomNumberGame.swift
//  RandomNumberGuesser
//
//  Created by Roderick van der Weerdt on 04-09-15.
//  Copyright (c) 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class RandomNumberGame {
    var highestNumber: UInt32 = 101
    var randomNumber: UInt32
    
    init(){
        self.randomNumber = arc4random_uniform(highestNumber)
    }
    
    func checkGuess(guess: UInt32) -> Bool{
        if (guess == self.randomNumber){
            return true
        }else{
            return false
        }
    }
    
    func checkIsHigher(guess: UInt32) -> Bool{
        if (guess > self.randomNumber){
            return true
        }else{
            return false
        }
    }
    
}