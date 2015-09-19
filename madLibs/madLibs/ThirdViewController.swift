//
//  ThirdViewController.swift
//  madLibs
//
//  Created by Roderick van der Weerdt on 18-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!

    var madLibText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = madLibText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
