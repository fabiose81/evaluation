//
//  EleveObj.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation


class EleveObj: NSObject, NSCoding {
    
    var id: Int!
    var name: String!
    var score: [Int]
    
    init(id: Int!, name: String!, score: [Int]!) {
        self.id = id
        self.name = name
        self.score = score
    }
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int
        name = decoder.decodeObject(forKey: "name") as? String
        score = (decoder.decodeObject(forKey: "score") as? [Int])!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(score, forKey: "score")
    }
}

