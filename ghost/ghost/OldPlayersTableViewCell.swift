// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com

//
//  OldPlayersTableViewCell.swift
//  ghost
//
//  Created by Roderick van der Weerdt on 07-10-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class OldPlayersTableViewCell: UITableViewCell {

    var player: Player?
   
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var winsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //    let viewController = segue.destinationViewController as! MainMenuViewController
    //    viewController.preferences.player1 = player
    //}
    
}
