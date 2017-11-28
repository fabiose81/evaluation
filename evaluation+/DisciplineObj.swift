//
//  SujetObj.swift
//  evaluation+
//
//  Created by eleves on 2017-11-28.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation

class DisciplineObj: NSObject, NSCoding {
    
    var id: Int64!
    var desc: String!
    var criterias: [CriteriaObj]
    
    init(id: Int64!, desc: String!, criterias: [CriteriaObj]!) {
        self.id = id
        self.desc = desc
        self.criterias = criterias
    }
    
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        desc = decoder.decodeObject(forKey: "desc") as? String
        criterias = (decoder.decodeObject(forKey: "criterias") as? [CriteriaObj])!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(desc, forKey: "desc")
        coder.encode(criterias, forKey: "criterias")
    }
}
