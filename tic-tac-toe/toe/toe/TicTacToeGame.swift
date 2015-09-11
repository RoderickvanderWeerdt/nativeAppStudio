//
//  TicTacToeGame.swift
//  toe
//
//
//
// The Gameboard should be viewed as index (n) of the array board:
// 0 1 2
// 3 4 5
// 6 7 8
// wherein a value of '0' is an empty field, '1' is taken by player1,
// and '2' is taken by player2.
//
// It checks to see if someone won or if there aren't any moves left,
// if that is the case it will produce an alert and the possibility to
// start a new game.
//
//  Created by Roderick van der Weerdt on 09-09-15.
//  Copyright (c) 2015 Roderick van der Weerdt. All rights reserved.
//

import Foundation

class TicTacToeGame {
    //game constants
    let emptyBoard = [0,0,0, 0,0,0, 0,0,0]
    let winningCombinations = [[0,3,6],[1,4,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]
    
    
    //game variables
    var board: Array<Int>
    let playerOneChar: Character
    let playerTwoChar: Character
    var playerOneTurn: Bool

    
    init(pOneChar: Character, pTwoChar: Character){
        self.board = emptyBoard
        self.playerOneChar = pOneChar
        self.playerTwoChar = pTwoChar
        self.playerOneTurn = true
    }
    
    func tilePressed(boardTile: Int) -> Character{
            if(self.playerOneTurn){
                board[boardTile] = 1
                return self.playerOneChar
            }else{
                board[boardTile] = 2
                return self.playerTwoChar
            }
    }
    
    func getPlayerAtTurn() -> Character {
        if(self.playerOneTurn){
            return self.playerOneChar
        }else{
            return self.playerTwoChar
        }
    }
    
    func changePlayerTurn(){
        if(self.playerOneTurn){
            self.playerOneTurn = false
        }else{
            self.playerOneTurn = true
        }
    }
    
    func gameWon() ->Bool{
        if(someoneWon()){
            return true
        }else{
            changePlayerTurn()
            return false
        }
    }
    
    func threeInARow(one: Int, two: Int, three: Int)->Bool{
        if((one == two) && (two == three)){
            return true
        }else{
            return false
        }
    }
    
    func gameExhausted()->Bool{
        for tile in board{
            if(tile == 0){
                return false
            }
        }
        return true
    }
    
    func someoneWon()->Bool{
        for winningScenario in winningCombinations{
            if((!isEmptyField(winningScenario[0])) && (threeInARow(self.board[winningScenario[0]], two: self.board[winningScenario[1]], three: self.board[winningScenario[2]]))){
                return true
            }
        }
        return false
    }
    
    func isEmptyField(boardTile: Int) -> Bool{
        if(self.board[boardTile] == 0){
            return true
        }else{
            return false
        }
    }
    
    //tester
    func printBoard(){
        print(self.board[0])
        print(self.board[1])
        println(self.board[2])
        print(self.board[3])
        print(self.board[4])
        println(self.board[5])
        print(self.board[6])
        print(self.board[7])
        println(self.board[8])

    }
    
    
}
    