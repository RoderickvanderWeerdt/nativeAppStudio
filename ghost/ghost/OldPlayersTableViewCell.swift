// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  OldPlayersTableViewCell.swift
//  ghost
//
//  The prototype table cell used by 'OldPlayersTableViewController.swift'.
//

import UIKit

class OldPlayersTableViewCell: UITableViewCell {

    var player: Player?
   
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var winsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
