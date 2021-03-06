//
//  ViewController.swift
//  toe
//
//  Created by Roderick van der Weerdt on 09-09-15.
//  Copyright (c) 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game = TicTacToeGame(pOneChar: "X", pTwoChar: "O")

    override func viewDidLoad() {
        super.viewDidLoad()
        clearBoard()
        self.game = TicTacToeGame(pOneChar: "X", pTwoChar: "O")
    }
    
    //The buttons representing the gameBoard.
    @IBOutlet var Tile0: UIButton!
    @IBOutlet var Tile1: UIButton!
    @IBOutlet var Tile2: UIButton!
    @IBOutlet var Tile3: UIButton!
    @IBOutlet var Tile4: UIButton!
    @IBOutlet var Tile5: UIButton!
    @IBOutlet var Tile6: UIButton!
    @IBOutlet var Tile7: UIButton!
    @IBOutlet var Tile8: UIButton!
    
    //The universal function which is called when a button is pressed.
    func TilePressed(boardTile: Int, button: UIButton){
        if(game.isEmptyField(boardTile)){
            button.setTitle(String(game.tilePressed(boardTile)), forState: UIControlState())
            if(game.gameWon()){
                gameWon(game.getPlayerAtTurn())
            }else if(game.gameExhausted()){
                gameOver()
            }
        }
    }
    
    func clearBoard(){
        let tileBoard = [Tile0, Tile1, Tile2, Tile3, Tile4, Tile5, Tile6, Tile7, Tile8]
        for tile in tileBoard {
            tile.setTitle("", forState: UIControlState())
        }
    }

    //The Actions for each individual button.
    @IBAction func Tile0Pressed()  {
        TilePressed(0, button: Tile0)
    }
    
    @IBAction func Tile1Pressed()  {
        TilePressed(1, button: Tile1)
    }
    
    @IBAction func Tile2Pressed()  {
        TilePressed(2, button: Tile2)
    }
    
    @IBAction func Tile3Pressed()  {
        TilePressed(3, button: Tile3)
    }
    
    @IBAction func Tile4Pressed()  {
        TilePressed(4, button: Tile4)
    }
    
    @IBAction func Tile5Pressed()  {
        TilePressed(5, button: Tile5)
    }
    
    @IBAction func Tile6Pressed()  {
        TilePressed(6, button: Tile6)
    }
    
    @IBAction func Tile7Pressed()  {
        TilePressed(7, button: Tile7)
    }
    
    @IBAction func Tile8Pressed()  {
        TilePressed(8, button: Tile8)
    }
    
    //this function creates the alert message showing that a player has won.
    func gameWon(winner: Character){
        let endMessage = "Player " + String(winner) + " has won!"
        let alertController = UIAlertController(title: "Congratulations!", message: endMessage, preferredStyle: .Alert)
        
        let newGameAction = UIAlertAction(title: "New Game", style: .Default) { (action:UIAlertAction) in
            self.clearBoard()
            self.game = TicTacToeGame(pOneChar: "X", pTwoChar: "O")
            print("Started a new game")
        }
        alertController.addAction(newGameAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    
    //this function creates the alert message showing there are no possible moves left to play.
    func gameOver(){
        let alertController = UIAlertController(title: "too bad..", message: "Nobody Won", preferredStyle: .Alert)
        
        let newGameAction = UIAlertAction(title: "New Game", style: .Default) { (action:UIAlertAction) in
            self.clearBoard()
            self.game = TicTacToeGame(pOneChar: "X", pTwoChar: "O")
            print("Started a new game")
        }
        alertController.addAction(newGameAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

