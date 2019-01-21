//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/6/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemArray : Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = itemArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType =  item.done ? .checkmark : .none
        }
        else{
            cell.textLabel?.text =  "No items added"
        }
        
        return cell
    }
    

    // MARK: - Table view delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                    //item.done = !item.done
                }
            }
            catch{
                print("Error on deleting done\(error)")
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var localTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks add item button on UIAlert
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                        let item = Item()
                        item.title = localTextField.text!
                        item.dateCreated = Date()
                        currentCategory.items.append(item)
                        self.realm.add(item)
                    }
                }
                catch{
                    print("Error saving context,\(error)")
                }
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            localTextField = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    
    func loadItems(){
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
}


extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" {
            itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
            tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadItems()
        }
    }

}

