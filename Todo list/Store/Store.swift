//
//  Store.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var itemGroups: ItemGroupState = ItemGroupState();
}

func appReducer(action: Action, state: AppState?) -> AppState{
    return AppState(
        itemGroups: itemsReducer(action: action, state: state?.itemGroups)
    );
}

let store = Store(
    reducer: appReducer,
    state: AppState()
)
