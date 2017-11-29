//
//  CriteriaObj.swift
//  evaluation+
//
//  Created by eleves on 2017-11-21.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation

class CriteriaObj: NSObject, NSCoding {
    
    var id: Int64!
    var desc: String
    var weight: String
    var ponctuation: String
        
    init(id: Int64!, desc: String!, weight: String!, ponctuation: String!) {
        self.id = id
        self.desc = desc
        self.weight = weight
        self.ponctuation = ponctuation
    }
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        desc = (decoder.decodeObject(forKey: "desc") as? String)!
        weight = (decoder.decodeObject(forKey: "weight") as? String)!
        ponctuation = (decoder.decodeObject(forKey: "ponctuation") as? String)!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(desc, forKey: "desc")
        coder.encode(weight, forKey: "weight")
        coder.encode(ponctuation, forKey: "ponctuation")
    }
}
