//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/6/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.itemName
        
        cell.accessoryType =  item.isDone ? .checkmark : .none
        
        return cell
    }
    

    // MARK: - Table view delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var localTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks add item button on UIAlert
            
            let item = Item()
            item.itemName = localTextField.text!
            item.isDone = false
            self.itemArray.append(item)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            localTextField = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }


}
