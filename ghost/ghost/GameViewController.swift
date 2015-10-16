// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  ViewController.swift
//  ghost
//
//  This view contains the actual gameplay, it creates a keyboard at the bottom
//  of the screen which can be used to play the letters, the playersturn is indicated
//  by the names at the top, the orange name is the 'active' player.
//  The current wordfragment is displayed in the middle of the screen, with a dot 
//  representing the next letter.
//

import UIKit

class GameViewController: UIViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    
    //for own use
    var game = Game()
    var gameState = GhostGameState()

    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var hButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    @IBOutlet weak var jButton: UIButton!
    @IBOutlet weak var kButton: UIButton!
    @IBOutlet weak var lButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var nButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var qButton: UIButton!
    @IBOutlet weak var rButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var tButton: UIButton!
    @IBOutlet weak var uButton: UIButton!
    @IBOutlet weak var vButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var yButton: UIButton!
    @IBOutlet weak var zButton: UIButton!

    @IBAction func aButtonPressed() {
        buttonPressed("a")
    }
    @IBAction func bButtonPressed() {
        buttonPressed("b")
    }
    @IBAction func cButtonPressed() {
        buttonPressed("c")
    }
    @IBAction func dButtonPressed() {
        buttonPressed("d")
    }
    @IBAction func eButtonPressed() {
        buttonPressed("e")
    }
    @IBAction func fButtonPressed() {
        buttonPressed("f")
    }
    @IBAction func gButtonPressed() {
        buttonPressed("g")
    }
    @IBAction func hButtonPressed() {
        buttonPressed("h")
    }
    @IBAction func iButtonPressed() {
        buttonPressed("i")
    }
    @IBAction func jButtonPressed() {
        buttonPressed("j")
    }
    @IBAction func kButtonPressed() {
        buttonPressed("k")
    }
    @IBAction func lButtonPressed() {
        buttonPressed("l")
    }
    @IBAction func mButtonPressed() {
        buttonPressed("m")
    }
    @IBAction func nButtonPressed() {
        buttonPressed("n")
    }
    @IBAction func oButtonPressed() {
        buttonPressed("o")
    }
    @IBAction func pButtonPressed() {
        buttonPressed("p")
    }
    @IBAction func qButtonPressed() {
        buttonPressed("q")
    }
    @IBAction func rButtonPressed() {
        buttonPressed("r")
    }
    @IBAction func sButtonPressed() {
        buttonPressed("s")
    }
    @IBAction func tButtonPressed() {
        buttonPressed("t")
    }
    @IBAction func uButtonPressed() {
        buttonPressed("u")
    }
    @IBAction func vButtonPressed() {
        buttonPressed("v")
    }
    @IBAction func wButtonPressed() {
        buttonPressed("w")
    }
    @IBAction func xButtonPressed() {
        buttonPressed("x")
    }
    @IBAction func yButtonPressed() {
        buttonPressed("y")
    }
    @IBAction func zButtonPressed() {
        buttonPressed("z")
    }

    func buttonPressed(letter: String){
        if(game.guess(Character(letter))){
            setButtons(game.possibilities())
            setWordFragment()
            if(game.ended()){
                gameState.finished = true
                winningButton.hidden = false
                print("the word is:" + game.wordFragment)
                print("congratulations "+game.winner().name+"!")
                game.winner().victory()
                savePreferences()
            }else{
                changeTurn()
            }
            gameState.wordFragment = game.wordFragment
            saveGameState()
        }
    }
    
    @IBOutlet weak var wordFragment: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var winningButton: UIButton!
    
    //let's you immediately start a new game (without winners or losers).
    @IBAction func newGameButton(sender: AnyObject) {
        game.reset()
        winningButton.hidden = true
        setWordFragment()
        setButtons(game.possibilities())
        changeTurn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winningButton.hidden = true
        
        if(gameState.finished){ //newgame
            setGameState()
            self.game = Game(lexicon: self.lexicons.lexicons[self.preferences.currentLexicon], player1: self.preferences.player1, player2: self.preferences.player2)
        }else{                  //recovered game
            self.preferences.player1 = self.gameState.player1
            self.preferences.player2 = self.gameState.player2
            self.preferences.addPlayers()
            self.game = Game(gameState: self.gameState, lexicon: self.lexicons.lexicons[self.gameState.language], player1: self.preferences.player1, player2: self.preferences.player2)
            setWordFragment()
        }
        
        setPlayerNames()
        setButtons(game.possibilities())
        changeTurn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //gives every available letter on the keyboard another color, so the user knows which letters are possible to play.
    func setButtons(possibilities: Array<Character>){
        let buttons = [["a", aButton],["b", bButton],["c", cButton],["d", dButton],["e", eButton],["f", fButton],["g", gButton],["h", hButton],
            ["i", iButton],["j", jButton],["k", kButton],["l", lButton],["m", mButton],["n", nButton],["o", oButton],["p", pButton],["q", qButton],
            ["r", rButton],["s", sButton], ["t", tButton], ["u", uButton],["v", vButton],["w", wButton],["x", xButton],["y", yButton],["z", zButton]]
        for button in buttons{
            (button[1] as! UIButton).backgroundColor = UIColor.purpleColor()
            for possibility in possibilities{
                if String(button[0]) == String(possibility){
                    (button[1] as! UIButton).backgroundColor = UIColor.greenColor()
                }
            }
        }
    }
    
    func setWordFragment(){
        var currentWord = self.game.wordFragment
        if(!self.game.ended()){
            currentWord += "●"
        }
        wordFragment.text = currentWord
    }
    
    func changeTurn(){
        if(game.player1Turn()){
            self.player1Label.textColor = UIColor.orangeColor()
            self.player2Label.textColor = UIColor.blackColor()
        }else{
            self.player1Label.textColor = UIColor.blackColor()
            self.player2Label.textColor = UIColor.orangeColor()
        }
    }
    
    //prepares a new gameState to be saved (and possible loaded if the game won't be finished).
    func setGameState(){
        self.gameState.finished = false
        self.gameState.player1 = self.preferences.player1
        self.gameState.player2 = self.preferences.player2
        self.gameState.language = self.preferences.currentLexicon
    }
    
    func setPlayerNames(){
        self.player1Label.text = self.preferences.player1.name
        self.player2Label.text = self.preferences.player2.name
    }
    
    func savePreferences() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(preferences, toFile: GhostPreferences.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save preferences...")
        }else{
            print("saved preferences")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowGameWon" {
            let viewController = segue.destinationViewController as! GameWonViewController
            viewController.word = game.wordFragment
            viewController.winner = game.winner()
            viewController.loser = game.loser()
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }else if segue.identifier == "ShowMainMenuSegue" {
            let viewController = segue.destinationViewController as! MainMenuViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }
        game.reset()
    }
    
    // MARK: Archiving
    func saveGameState() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(gameState, toFile: GhostGameState.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save game state...")
        }else{
            print("saved game state")
        }
    }
    
    func loadGameState() -> GhostGameState? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GhostGameState.ArchiveURL.path!) as? GhostGameState
    }
    

}

