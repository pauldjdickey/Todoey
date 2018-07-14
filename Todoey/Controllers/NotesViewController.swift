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

class NotesViewController: UIViewController {
    
    let realm = try! Realm()
    var noteItems: Results<Note>?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
