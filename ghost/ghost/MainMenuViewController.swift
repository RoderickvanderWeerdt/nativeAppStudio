// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  MainMenuViewController.swift
//  ghost
//
//  The Main Menu of the game, from which the game can be started and in which
//  preferences can be changed (like the names of the players and the language
//  of the lexicon.
//

import UIKit

class MainMenuViewController: UIViewController, UITextFieldDelegate {
    //default
    let dutch: Int = 0
    let english: Int = 1
    
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()

    @IBOutlet weak var player1Field: UITextField!
    @IBOutlet weak var player2Field: UITextField!
    
    @IBOutlet weak var playerNamesMissingLabel: UILabel!
    @IBOutlet weak var StartGameButton: UIButton!
    
    @IBOutlet weak var lexiconButton: UIButton!
    @IBAction func LexiconButton(sender: AnyObject) {
        if(lexiconButton.titleForState(UIControlState()) == "🇳🇱"){
            preferences.useLexicon(english)
            lexiconButton.setTitle("🇬🇧", forState: UIControlState())
        }else if(lexiconButton.titleForState(UIControlState()) == "🇬🇧"){
            preferences.useLexicon(dutch)
            lexiconButton.setTitle("🇳🇱", forState: UIControlState())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1Field.delegate = self
        player2Field.delegate = self
        
        player1Field.text = self.preferences.player1.name
        player2Field.text = self.preferences.player2.name
        setLexiconButton()
        
        checkPlayerNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowGameSegue" {
            let viewController = segue.destinationViewController as! GameViewController
            self.preferences.player1 = Player(playerName: player1Field.text!)
            self.preferences.player2 = Player(playerName: player2Field.text!)
            self.preferences.addPlayers()
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
            
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
            
        }else if (segue.identifier == "ShowHowToSegue"){
            let viewController = segue.destinationViewController as! HowToGhostViewController
            viewController.preferences = self.preferences
            viewController.lexicons = self.lexicons
        }
    }
    
    //Change the lexicon
    func setLexiconButton(){
        if(self.preferences.currentLexicon == dutch){
            lexiconButton.setTitle("🇳🇱", forState: UIControlState())
        }else if(self.preferences.currentLexicon == english){
            lexiconButton.setTitle("🇬🇧", forState: UIControlState())
        }else{
            print("ERROR, failed to load lexicon")
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
    
    //checks if the players have names, and hides the 'start game'-button if they aren't.
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

}