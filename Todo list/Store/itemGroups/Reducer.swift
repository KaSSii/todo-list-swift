//
//  Reducer.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import ReSwift;
import RealmSwift;


func itemsReducer(action: Action, state: ItemGroupState?) -> ItemGroupState {
    var state = state ?? ItemGroupState();
    
    let realm = try! Realm();
    
    switch action {
    case let action as addGroupAction:
        state.groups.append(action.group);
        
        try! realm.write {
            realm.add(action.group);
        }
        
        break;
    case let action as removeGroupAction:
        let item = state.groups[action.id];
        state.groups.remove(at: action.id)
        
        try! realm.write {
            realm.delete(item);
        }
        break;
    case let action as updateTodoListAction:
        try! realm.write {
            action.group.items.append(action.item);
        }
        break;
    case let action as initialLoad:
        state.groups = action.groups;
    default:
        break;
    }
    
    return state;
}
