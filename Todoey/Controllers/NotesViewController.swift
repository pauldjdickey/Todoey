//
//  NotesViewController.swift
//  Todoey
//
//  Created by Paul Dickey2 on 7/14/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class NotesViewController: UIViewController, UITextViewDelegate {
    
    let realm = try! Realm()
    var noteItems: Results<Item>?
    
    @IBOutlet weak var noteText: UITextView!
    
    var selectedItem : Item? {
        // Did set only happens once the variable has a value
        didSet {
            // loadItems() - This causes an error... why?
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // This is where we will call load items, which will add the text from the associated note data model to the view
    }
    //MARK: Put in what data will be loaded and how
    
    
    //MARK: Model Manipulation Methods
    func loadItems() {
       title = selectedItem!.title // This works! Now how to make it so the text is from the model we want?
       noteText.text = selectedItem!.note
        
        
//        if let note = noteItems { // THis will be used to set the note text from when we saved it
//            noteText.text = "Hello"
//        } else {
//            print("load items has failed")
//        }

        
       // noteItems = selectedItem?.notes.
        
        // tableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {        
        do {
            try self.realm.write {
                selectedItem?.note = noteText.text
            }
        } catch {
            print("error saving new items, \(error)")
        }
        
//        if let currentCategory = self.selectedItem {
//            do {
//                try self.realm.write {
//                    let newItem = Item()
//                    newItem.note = noteText.text
//                    newItem.dateCreated = Date()
//                    currentCategory.note.append(newItem)
//                }
//            } catch {
//                print("Error saving new items, \(error)")
//            }
//        }
    }
    
    
//    if let currentCategory = self.selectedCategory {
//        do {
//            try self.realm.write {
//                let newItem = Item()
//                newItem.title = textField.text!
//                newItem.done = false
//                newItem.dateCreated = Date()
//                currentCategory.items.append(newItem)
//            }
//        } catch {
//            print("Error saving new items, \(error)")
//        }
//    }
    

}
