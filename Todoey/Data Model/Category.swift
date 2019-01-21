//
//  Category.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/11/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
