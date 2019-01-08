//
//  Item.swift
//  Todoey
//
//  Created by Nandu, Ameen - Contractor {BIS} on 1/8/19.
//  Copyright © 2019 Nandu, Ameen - Contractor {BIS}. All rights reserved.
//

import UIKit

class Item: Encodable, Decodable {

    var itemName : String = ""
    var isDone : Bool = false
}
