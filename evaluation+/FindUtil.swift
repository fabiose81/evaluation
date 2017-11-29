//
//  FindUtil.swift
//  evaluation+
//
//  Created by Fabio Estrela on 17-11-28.
//  Copyright © 2017 eleves. All rights reserved.
//

import Foundation

class FindUtil: NSObject{
    
    func findDisciplineByCriteria(id: Int64) -> Bool
    {
        let userDefaultsManager = UserDefaultsManager()
        
        if userDefaultsManager.doesKeyExist(theKey: "disciplines") {
            let data = userDefaultsManager.getData(theKey: "disciplines")
            let disciplines = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [DisciplineObj])!
            
            for discipline in disciplines
            {
                for criteria in discipline.criterias
                {
                    if criteria.id == id
                    {
                        return true;
                    }
                }
            }
        }
        return false
    }
    
    func findEleveByDiscipline(id: Int64) -> Bool
    {
        let userDefaultsManager = UserDefaultsManager()
        
        if userDefaultsManager.doesKeyExist(theKey: "eleves") {
            let data = userDefaultsManager.getData(theKey: "eleves")
            let eleves = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [EleveObj])!
            
            for eleve in eleves
            {
                for discipline in eleve.disciplines
                {
                    if discipline.id == id
                    {
                        return true;
                    }
                }
            }
        }
        return false
    }
}
