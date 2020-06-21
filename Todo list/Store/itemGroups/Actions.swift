//
//  Actions.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import ReSwift
import RealmSwift;

struct initialLoad: Action {
    let groups: [ItemGroup];
}

struct addGroupAction: Action {
    let group: ItemGroup;
}

struct removeGroupAction: Action {
    let id: Int;
}

struct updateTodoListAction: Action {
    let group: ItemGroup;
    let item: Item;
}
