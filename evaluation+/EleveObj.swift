//
//  EleveObj.swift
//  evaluation+
//
//  Created by Fabio Estrela on 2017-11-16.
//  Copyright © 2017 Fabio Estrela. All rights reserved.
//

import Foundation

//Structure pour le object de la class Eleve
class EleveObj: NSObject, NSCoding {
    
    var id: Int64!
    var name: String!
    var disciplines: [DisciplineObj]
    
    init(id: Int64!, name: String!,disciplines: [DisciplineObj]!) {
        self.id = id
        self.name = name
        self.disciplines = disciplines
    }
    
    //Fonction pour la decodification de la structure pour l'utilisation de UserDefaults
    required init(coder decoder: NSCoder) {
        id = decoder.decodeObject(forKey: "id") as? Int64
        name = decoder.decodeObject(forKey: "name") as? String
        disciplines = (decoder.decodeObject(forKey: "disciplines") as? [DisciplineObj])!
    }
    
    //Fonction pour la codification de la structure pour l'utilisation de UserDefaults
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(disciplines, forKey: "disciplines")
    }
}

