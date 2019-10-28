//
//  ViewController.swift
//  Todoey
//
//  Created by mac on 23/10/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)

        loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]
//        {
//            itemArray  = items
//        }
 
    }
    var itemArray = [Item]()
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return itemArray.count
       }
    
    //MARK - Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //MARK -  Using Ternary Operator instead of IF ELSE Statements
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else
//        {
//            cell.accessoryType = .none
//
//        }
        return cell
    }

    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
    }
    
    //MARK - ADD Button Action
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            
            self.saveItems()
            
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Todoey"
            textField = alertTextField
            
        }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print(error)
            
        }
        tableView.reloadData()
    
    }
    func loadItems()
    {
        
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
        do{
            itemArray = try decoder.decode([Item].self, from: data!)
            
        }catch
        {
            print(error)
        }
        
    }
    
    
    }
    


