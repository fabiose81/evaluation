//
//  EleveObj.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation


class EleveObj: NSObject, NSCoding {
    
    var id: Int64!
    var name: String!
    var discipline: [DisciplineObj]
    
    init(id: Int64!, name: String!,discipline: [DisciplineObj]!) {
        self.id = id
        self.name = name
        self.discipline = discipline
    }
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        name = decoder.decodeObject(forKey: "name") as? String
        discipline = (decoder.decodeObject(forKey: "discipline") as? [DisciplineObj])!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(discipline, forKey: "discipline")
    }
}

