//
//  DisciplineObj
//  evaluation+
//
//  Created by Fabio Estrela on 2017-11-28.
//  Copyright © 2017 Fabio Estrela. All rights reserved.
//

import Foundation

//Structure pour le object de la class Discipline
class DisciplineObj: NSObject, NSCoding {
    
    var id: Int64!
    var desc: String!
    var criterias: [CriteriaObj]
    
    init(id: Int64!, desc: String!, criterias: [CriteriaObj]!) {
        self.id = id
        self.desc = desc
        self.criterias = criterias
    }
    
    //Fonction pour la decodification de la structure pour l'utilisation de UserDefaults
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        desc = decoder.decodeObject(forKey: "desc") as? String
        criterias = (decoder.decodeObject(forKey: "criterias") as? [CriteriaObj])!
    }
    
    //Fonction pour la codification de la structure pour l'utilisation de UserDefaults
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(desc, forKey: "desc")
        coder.encode(criterias, forKey: "criterias")
    }
}
