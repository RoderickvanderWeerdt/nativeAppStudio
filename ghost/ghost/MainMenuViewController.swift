// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  MainMenuViewController.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UITextFieldDelegate {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()

    @IBOutlet weak var player1Field: UITextField!
    @IBOutlet weak var player2Field: UITextField!
    
    @IBOutlet weak var playerNamesMissingLabel: UILabel!
    @IBOutlet weak var StartGameButton: UIButton!
    
    
    @IBOutlet weak var hackyLexiconSolution: UIButton!
    @IBAction func hackyLexiconSolution(sender: AnyObject) {
        self.lexicons.loadDutchLexicon()
        saveLexicons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1Field.delegate = self
        player2Field.delegate = self
        
//        if let savedPreferences = loadPreferences(){
//            print("yes preferences loaded")
//            self.preferences = savedPreferences
//        }else{
//            print("no preferences loaded")
//            savePreferences()
//        }
//        if let savedLexicons = loadLexicons(){
//            print("yes lexicons loaded")
//            self.lexicons = savedLexicons
//        }else{
//            print("no lexicons loaded")
//            //self.lexicons.loadDutchLexicon()
//            self.lexicons.loadTest1Lexicon()
//            self.lexicons.loadTest2Lexicon()
//            //self.lexicons.loadEnglishLexicon()
//            saveLexicons()
//        }
        
        player1Field.text = self.preferences.player1.name
        player2Field.text = self.preferences.player2.name
        
        checkPlayerNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowGameSegue" {
            let viewController = segue.destinationViewController as! ViewController
            self.preferences.player1 = Player(playerName: player1Field.text!)
            self.preferences.player2 = Player(playerName: player2Field.text!)
            self.preferences.addPlayers()
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
            
        }else if (segue.identifier == "ShowPreferencesSegue"){
            let viewController = segue.destinationViewController as! PreferencesViewController
            viewController.preferences = self.preferences
            viewController.lexicons = self.lexicons
            
        }else if (segue.identifier == "ShowP1ToPlayers"){
            let viewController = segue.destinationViewController as! OldPlayersTableViewController
            viewController.preferences = self.preferences
            viewController.lexicons = self.lexicons
            viewController.player = "player1"
            
        }else if (segue.identifier == "ShowP2ToPlayers"){
            let viewController = segue.destinationViewController as! OldPlayersTableViewController
            viewController.preferences = self.preferences
            viewController.lexicons = self.lexicons
            viewController.player = "player2"
        }else if (segue.identifier == "ShowWallOfFame"){
            let viewController = segue.destinationViewController as! WallOfFameTableViewController
            viewController.preferences = self.preferences
            viewController.lexicons = self.lexicons
        }
        
    }
    
    
    // MARK: TextField
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let maxLength = 12
        let currentString: NSString = textField.text!
        let newString: NSString = currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        checkPlayerNames()
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func checkPlayerNames(){
        if ((player1Field.text == "") || (player2Field.text == "")){
            playerNamesMissingLabel.hidden = false
            StartGameButton.hidden = true
        }else{
            playerNamesMissingLabel.hidden = true
            StartGameButton.hidden = false

        }
    }
    
    // MARK: NSCoding
    func savePreferences() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(preferences, toFile: GhostPreferences.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save preferences...")
        }else{
            print("saved preferences")
        }
    }
    
    func loadPreferences() -> GhostPreferences? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GhostPreferences.ArchiveURL.path!) as? GhostPreferences
    }
    
    func saveLexicons() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lexicons, toFile: LexiconCollection.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save lexicons...")
        }else{
            print("saved lexicons")
        }
    }
    
    func loadLexicons() -> LexiconCollection? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(LexiconCollection.ArchiveURL.path!) as? LexiconCollection
    }

}