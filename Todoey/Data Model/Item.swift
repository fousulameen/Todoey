//
//  Item.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/11/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
