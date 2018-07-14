//
//  Note.swift
//  Todoey
//
//  Created by Paul Dickey2 on 7/14/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var note : String = ""
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "notes")
}
