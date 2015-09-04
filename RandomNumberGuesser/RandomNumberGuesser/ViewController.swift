//
//  ViewController.swift
//  RandomNumberGuesser
//
//  Created by Roderick van der Weerdt on 04-09-15.
//  Copyright (c) 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let game = RandomNumberGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(game.randomNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var helpLabel: UILabel!

    
    @IBAction func leftButtonPressed()  {
        //NSLog("Button Pressed")
        if (self.view.backgroundColor == UIColor.greenColor()){
            self.view.backgroundColor = UIColor.grayColor()
        } else {
            self.view.backgroundColor = UIColor.greenColor()
        }
    }
    
    @IBOutlet weak var guessedNumber: UITextField!
    
    @IBAction func rightButtonPressed()  {
        //NSLog("Button Pressed")
        var guess = guessedNumber.text.toInt()
        if (guess > 0){
            var guesss = UInt32(guess!)
            if(self.game.checkGuess(guesss)){
                let alertController = UIAlertController(title: "Yes!", message: "You Have Won!", preferredStyle: .Alert)
                self.presentViewController(alertController, animated: true, completion:nil)
            }else{
                if(guesss > self.game.highestNumber){
                    helpLabel.text = "Try a number between 0 and 100"
                } else {
                    if(self.game.checkIsHigher(guesss)){
                        helpLabel.text = "Try a lower number"
                    } else{
                        helpLabel.text = "Try a higher number"
                    }
                }
            }
        } else {
            let alertController = UIAlertController(title: "NO!", message: "please enter a number!", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                println("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }


}

