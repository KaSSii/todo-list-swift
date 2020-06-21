//
//  State.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import ReSwift
import RealmSwift

struct ItemGroupState: StateType {
    var groups: [ItemGroup] = [];
}

class ItemGroup: Object {
    @objc dynamic var id: Int = 0;
    @objc dynamic var name: String = "";
    let items = List<Item>();
}

class Item: Object {
    @objc dynamic var id: Int = 0;
    @objc dynamic var name: String = "";
    var itemGroup = LinkingObjects(fromType: ItemGroup.self, property: "items");
}
