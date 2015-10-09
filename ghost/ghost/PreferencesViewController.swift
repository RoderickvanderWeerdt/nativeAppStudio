// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  PreferencesViewController.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 04-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    
    //default
    let dutch: Int = 0
    let english: Int = 1
    
    
    @IBOutlet weak var dutchButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    @IBAction func englishButton(sender: AnyObject) {
        useLexicon(english)
    }
    
    @IBAction func dutchButton(sender: AnyObject) {
        useLexicon(dutch)
    }
    
    @IBAction func resetLexicon(sender: AnyObject) {
        //self.preferences.loadEnglishLexicon()
        //self.preferences.loadDutchLexicon()
        //self.preferences.loadTest1Lexicon()
        //self.preferences.loadTest2Lexicon()
    }
    
    func useLexicon(language: Int){
        preferences.currentLexicon = language
        print("preferences.currentLexicon = " + String(preferences.currentLexicon))
        highlightCurrentLexicon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightCurrentLexicon()
    }
    
    private func highlightCurrentLexicon(){
        if (self.preferences.currentLexicon == dutch){
            englishButton.backgroundColor = UIColor.clearColor()
            dutchButton.backgroundColor = UIColor.orangeColor()
        }else if (self.preferences.currentLexicon == english){
            dutchButton.backgroundColor = UIColor.clearColor()
            englishButton.backgroundColor = UIColor.orangeColor()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMainMenu" {
            let viewController = segue.destinationViewController as! MainMenuViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }
    }
    
}