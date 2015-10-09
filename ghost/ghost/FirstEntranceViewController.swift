// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  FirstEntranceViewController.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 09-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class FirstEntranceViewController: UIViewController {
    //from start
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    var done = false
    
    var gameState = GhostGameState()

    
    @IBOutlet weak var introLabel1: UILabel!
    @IBOutlet weak var introLabel2: UILabel!
    
    @IBOutlet weak var loadDutchActivity: UIActivityIndicatorView!
    @IBOutlet weak var loadDutchButton: UIButton!
    @IBAction func loadDutchButton(sender: AnyObject) {
        loadDutchActivity.hidden = false
        loadDutchActivity.startAnimating()
        self.lexicons.loadDutchLexicon()//self.lexicons.loadTest1Lexicon()//
        saveLexicons()
        loadDutchActivity.stopAnimating()
        hideDutchLayOut()
        if(self.done == true){
            hideFirstEncounter()
        }else{
            self.done = true
        }
    }
    
    @IBOutlet weak var loadEnglishActivity: UIActivityIndicatorView!
    @IBOutlet weak var loadEnglishButton: UIButton!
    @IBAction func loadEnglishButton(sender: AnyObject) {
        loadEnglishActivity.hidden = false
        loadEnglishActivity.startAnimating()
        self.lexicons.loadEnglishLexicon()//self.lexicons.loadTest2Lexicon()//
        saveLexicons()
        loadEnglishActivity.stopAnimating()
        hideEnglishLayOut()
        if(self.done == true){
            hideFirstEncounter()
        }else{
            self.done = true
        }
    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var continueGameButton: UIButton!
    @IBAction func continueGameButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedPreferences = loadPreferences(){
            print("yes preferences loaded")
            self.preferences = savedPreferences
        }else{
            print("no preferences loaded")
            savePreferences()
        }
        if let savedLexicons = loadLexicons(){
            print("yes lexicons loaded")
            hideFirstEncounter()
            self.lexicons = savedLexicons
            
        }else{
            print("no lexicons loaded")
            firstEncounterLayOut()
            //self.lexicons.loadTest1Lexicon()
            //self.lexicons.loadTest2Lexicon()
            //saveLexicons()
        }
        
        if let savedGameState = loadGameState(){
            self.gameState = savedGameState
            print("gamestatefound")
            print(savedGameState.wordFragment)
        }else{
            print("no game state found")
        }
    }
    
    func firstEncounterLayOut(){
        introLabel1.hidden = false
        introLabel2.hidden = false
        loadDutchActivity.hidden = true
        loadDutchButton.hidden = false
        loadEnglishActivity.hidden = true
        loadEnglishButton.hidden = false
        
        continueGameButton.hidden = true
        startButton.hidden = true
    }
    
    
    func hideFirstEncounter(){
        introLabel1.hidden = true
        introLabel2.hidden = true
        loadDutchActivity.hidden = true
        loadDutchButton.hidden = true
        loadEnglishActivity.hidden = true
        loadEnglishButton.hidden = true
        
        startButton.hidden = false
        
        if(!self.gameState.finished){
            continueGameButton.hidden = false
        }else{
            continueGameButton.hidden = true
        }

    }
    
    func hideDutchLayOut(){
        introLabel1.hidden = false
        introLabel2.hidden = false
        loadDutchActivity.hidden = true
        loadDutchButton.hidden = true
        loadEnglishActivity.hidden = true
        loadEnglishButton.hidden = false
        
        continueGameButton.hidden = true
        startButton.hidden = true

    }
    
    func hideEnglishLayOut(){
        introLabel1.hidden = false
        introLabel2.hidden = false
        loadDutchActivity.hidden = true
        loadDutchButton.hidden = false
        loadEnglishActivity.hidden = true
        loadEnglishButton.hidden = true
        
        continueGameButton.hidden = true
        startButton.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func loadGameState() -> GhostGameState? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GhostGameState.ArchiveURL.path!) as? GhostGameState
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowMainMenuSegue"){
            let viewController = segue.destinationViewController as! MainMenuViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }else if(segue.identifier == "ShowGameSegue"){
            let viewController = segue.destinationViewController as! ViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
            viewController.gameState = self.gameState
        }
        
    }
    
}