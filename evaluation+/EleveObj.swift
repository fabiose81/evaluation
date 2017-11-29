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
    var disciplines: [DisciplineObj]
    
    init(id: Int64!, name: String!,disciplines: [DisciplineObj]!) {
        self.id = id
        self.name = name
        self.disciplines = disciplines
    }
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        name = decoder.decodeObject(forKey: "name") as? String
        disciplines = (decoder.decodeObject(forKey: "disciplines") as? [DisciplineObj])!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(disciplines, forKey: "disciplines")
    }
}

