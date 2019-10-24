//
//  ViewController.swift
//  Todoey
//
//  Created by mac on 23/10/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
       if let  items =   defaults.array(forKey: "TodoListArray") as? [String]
       {
        itemArray = items
        }
        // Do any additional setup after loading the view.
    }
    var itemArray = ["Karachi", "Lahore", "Islamabad"]
    let defaults = UserDefaults.standard
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return itemArray.count
       }
    
    //MARK - Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
   
    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - ADD Button Action
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        
            
            }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Todoey"
            textField = alertTextField
            
        }
        
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    


