// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober
//
//  HowToGhostViewController.swift
//  ghost
//
//  A view consisting of a textfield in which the basics of the game 'ghost' are explained.
//  The explanation used in the app is based on the first paragraph of the (english) wikipedia
//  page about Ghost (link: https://en.wikipedia.org/wiki/Ghost_(game))

import UIKit

class HowToGhostViewController: UIViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.preferences.player1.name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let viewController = segue.destinationViewController as! MainMenuViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
    }
}