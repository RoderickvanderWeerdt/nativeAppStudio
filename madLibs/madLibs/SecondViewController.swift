//
//  SecondViewController.swift
//  madLibs
//
//  Created by Roderick van der Weerdt on 18-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var madLibText: String = ""
    var madLibbie: MadLibs = MadLibs(gameMode: 0)
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet var gameOn: UIButton!
    @IBOutlet var confirm: UIButton!
    
    @IBOutlet weak var textField: UITextField!

    @IBAction func confirmPressed()  {
        madLibbie.putInWord(textField.text!)
        getNextWord()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameOn.hidden = true
        getNextWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.madLibbie.composeText()
        let thirdViewController = segue.destinationViewController as! ThirdViewController
        thirdViewController.madLibText = self.madLibbie.gameCompleteText
    }
    
    func getNextWord(){
        if(madLibbie.currentWord < madLibbie.gameWords.count){
            self.firstLabel.text = madLibbie.fillInWord()
        }else{
            self.firstLabel.text = "all done!"
            self.gameOn.hidden = false
            self.confirm.hidden = true
            self.textField.hidden = true
        }
    }

}
