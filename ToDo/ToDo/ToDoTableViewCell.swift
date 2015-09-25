//
//  ToDoTableViewCell.swift
//  Class for the cell showing the todo in the table.
//
//  Created by Roderick van der Weerdt on 24-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var todo: ToDo?

    @IBOutlet weak var todoLabel: UILabel!
    
    @IBOutlet weak var doneSwitch: UISwitch!
    
    @IBAction func isDone(sender: UISwitch) {
        if(self.todo!.done){
            self.todo!.done = false
        }else{
            self.todo!.done = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
