//
//  Item.swift
//  FetchTestApp
//
//  Created by Luke Morse on 1/18/20.
//  Copyright © 2020 Luke Morse. All rights reserved.
//

import Foundation

struct Item {
    let listId: Int
    let name: String
    
    init(listId: Int, name: String) {
        self.listId = listId;
        self.name = name;
    }
    
    init?(_ dictionary: [String: Any]) {
        guard let
            listId = dictionary["listId"] as? Int,
            let name = dictionary["name"] as? String else {return nil}
        if name == "" {return nil}
        self.listId = listId
        self.name = name
    }
}

