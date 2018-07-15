//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Paul Dickey2 on 7/7/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        print("View reloaded")
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // What happens when the add button is pressed
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            // newCategory.color = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: TableView Datasource Methods
    // How many cells to make
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    

    
    // What to display in those cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Because we call super, it goes into our super class and triggers cellforrowat index path code
        let cell = super.tableView(tableView, cellForRowAt: indexPath) // This sets up a cell, as the super controller has the dequeue method
        // These modify the cells
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size:20)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            // cell.backgroundColor = UIColor(hexString: category.color ?? "28AAC0") // If there is no color value, here is the default value
            // cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        }
        
        
        return cell
    }
    
    // MARK: TableView Delegate Methods
    // What happens when we select a certain cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: Data Manipulation Methods
    // Save Categories
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    // Load Categories
    func loadCategories() {
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    // Delete Categories from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error trying to delete category. \(error)")
            }
        }
    }
    
}

