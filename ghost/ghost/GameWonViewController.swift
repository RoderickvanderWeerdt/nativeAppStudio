// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  GameWonViewController.swift
//  ghost
//
//  A view to display the outcome of the game.
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