//
//  SecondViewController.swift
//  madLibs
//
//  Created by Roderick van der Weerdt on 18-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let thirdViewController = segue.destinationViewController as! ThirdViewController
        thirdViewController.first = "hello World"
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    //*/

}
