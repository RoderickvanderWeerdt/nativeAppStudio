// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015

//
//  WallOfFameTableViewController.swift
//  ghost
//
//  WallOfFameTableViewController is a table which contains all the previous players
//  of the game sorted by how much games they have won.
//

import UIKit

class WallOfFameTableViewController: UITableViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    var showNewGameButton = false
    
    @IBOutlet weak var startNewGameButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        sortPlayersByWins()
        super.viewDidLoad()
        setNewGameButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.preferences.players.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = "PlayersCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OldPlayersTableViewCell
        
        let player = self.preferences.players[indexPath.row]
        
        cell.player = player
        cell.playerNameLabel.text = player.name
        if(player.wins == 1){
            cell.winsLabel.text = "1 win"
        }else{
            cell.winsLabel.text = String(player.wins) + " wins"
        }
        
        return cell
    }
    
    func sortPlayersByWins(){
        self.preferences.players.sortInPlace({ $0.wins > $1.wins })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowGameSegue" {
            let viewController = segue.destinationViewController as! GameViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }else if segue.identifier == "ShowMainMenuSegue"{
            let viewController = segue.destinationViewController as! MainMenuViewController
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }
    }
    
    func setNewGameButton(){
        if(!self.showNewGameButton){
            startNewGameButton.enabled = false
        }
    }
    
}