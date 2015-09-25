//
//  TodoTableViewController.swift
//  ToDo is an iOS app which enables the user to create a todolist on his iPhone.
//
//  Created by Roderick van der Weerdt on 24-09-15.
//  Copyright © 2015 Roderick van der Weerdt. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    
    @IBOutlet weak var newToDoLabel: UITextField!
    
    var todos = [ToDo]()

    //The action for the button that creates a new ToDo
    @IBAction func addToDo(sender: AnyObject) {
        if(newToDoLabel.text != ""){
            newToDoLabel.resignFirstResponder();
            let newToDo: ToDo = ToDo(title: newToDoLabel.text!, done: false)
            self.todos += [newToDo]
            print(newToDoLabel.text)
        
            newToDoLabel.text = "";
            self.tableView.reloadData()
            saveToDos()
        }
    }

    @IBAction func saveButton(sender: AnyObject) {
        saveToDos()
    }
    
    //action to remove all action which are checked.
    @IBAction func clearToDones(sender: AnyObject) {
        var i:Int = 0
        while(i < todos.count){
            if(todos[i].done){
                todos.removeAtIndex(i)
            }else{
                i++
            }
        }
        saveToDos()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = loadToDos() {
            todos += savedToDos
        } else {
            loadSampleToDos()
        }
    }
    
    func loadSampleToDos() {
        let todo1 = ToDo(title: "think of things todo", done: false)
        let todo2 = ToDo(title: "fill todo list", done: false)
        let todo3 = ToDo(title: "do todos", done: false)
        todos += [todo1, todo2, todo3]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = "ToDoTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToDoTableViewCell
        
        let todo = todos[indexPath.row]
        
        cell.todo = todo
        cell.todoLabel.text = todo.title
        if todo.done{
            cell.doneSwitch.on = true
        }else{
            cell.doneSwitch.on = false
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSCoding
    func saveToDos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todos, toFile: ToDo.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save todos...")
        }
    }

    func loadToDos() -> [ToDo]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ToDo.ArchiveURL.path!) as? [ToDo]
    }
}
