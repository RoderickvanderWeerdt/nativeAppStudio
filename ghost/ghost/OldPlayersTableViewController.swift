// Roderick van der Weerdt - 10680195
// rvanderweerdt@hotmail.com - oktober 2015
//
//  OldPlayersTableViewController.swift
//  ghost
//
//  OldPlayersTableViewController is a table which contains all the previous players
//  of the game. A player can be selected to use in a new game.
//

import UIKit

class OldPlayersTableViewController: UITableViewController {
    //from segue
    var preferences = GhostPreferences()
    var lexicons = LexiconCollection()
    
    var player = ""
    
    override func viewDidLoad() {
        sortPlayersByName()
        super.viewDidLoad()
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
        let cellIdentifier = "OldPlayersTableViewCell"
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
    
    func sortPlayersByName(){
        self.preferences.players.sortInPlace({ $0.name < $1.name })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! MainMenuViewController
        if segue.identifier == "ShowMainMenu" {
            print((sender?.player!!.name)!)
            if player == "player1"{
                self.preferences.player1 = (sender?.player!)!
            }else if player == "player2"{
                self.preferences.player2 = (sender?.player!)!
            }
            self.savePreferences()
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }else if segue.identifier == "returnToMainMenuSegue"{
            viewController.lexicons = self.lexicons
            viewController.preferences = self.preferences
        }
    }
    
    func savePreferences() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(preferences, toFile: GhostPreferences.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save preferences...")
        }else{
            print("saved preferences")
        }
    }
}