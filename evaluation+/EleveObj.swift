//
//  EleveObj.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation


class EleveObj {
    
    var id: Int!
    var name: String!
    var score: [Int]
    
    init(id: Int!, name: String!, score: [Int]!) {
        self.id = id
        self.name = name
        self.score = score
    }
}
