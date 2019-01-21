//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/9/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    
    let realm = try! Realm()
    
    var categoryArray : Results <Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added"
        
        return cell

    }
    
    // MARK: - Table view delegates methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row] 
        }
        
            
        
    }
    // MARK: - Data manupulation methods
    
    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func save(category: Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving context,\(error)")
        }
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var localTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once user clicks add category button on UIAlert
            
            let category = Category()
            category.name = localTextField.text!
            self.save(category: category)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new category"
            localTextField = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}
