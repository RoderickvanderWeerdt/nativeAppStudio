//
//  ViewController.swift
//  madLibs
//
//  Created by Roderick van der Weerdt on 18-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var madLibbie: MadLibs = MadLibs(gameMode: 0)


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Pressed0()  {
        self.madLibbie = MadLibs(gameMode: 0)
    }
    
    @IBAction func Pressed1()  {
        self.madLibbie = MadLibs(gameMode: 1)
    }
    
    @IBAction func Pressed2()  {
        self.madLibbie = MadLibs(gameMode: 2)
    }
    
    @IBAction func Pressed3()  {
        self.madLibbie = MadLibs(gameMode: 3)
    }
    
    @IBAction func Pressed4()  {
        self.madLibbie = MadLibs(gameMode: 4)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.madLibbie.composeText()
        let secondViewController = segue.destinationViewController as! SecondViewController
        secondViewController.madLibbie = self.madLibbie
    }

}

