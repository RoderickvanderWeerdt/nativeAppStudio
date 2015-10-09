// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  GameWonViewController.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class GameWonViewController: UIViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()


    
    var word: String = ""
    var winner: Player = Player()
    var loser: Player = Player()
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var loserLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.winnerLabel.text = self.winner.name
        self.loserLabel.text = self.loser.name
        self.wordLabel.text = self.word
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWallOfFame" {
            let viewController = segue.destinationViewController as! WallOfFameTableViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
            viewController.showNewGameButton = true
        }
    }
    
}