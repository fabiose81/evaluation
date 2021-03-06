//
//  DisciplineViewController.swift
//  evaluation+
//
//  Created by Fabio Estrela on 2017-11-28.
//  Copyright © 2017 Fabio Estrela. All rights reserved.
//

import UIKit

//Class pour la cellule customisé de la tableview
class DisciplineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDescriptionDiscipline: UILabel!
    
}

class DisciplineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var tableViewDisciplines: UITableView!
    @IBOutlet weak var tableViewCriterias: UITableView!
    
    var disciplines = [DisciplineObj]()
    var criterias = [CriteriaObj]()
    var criteriasDiscipline = [CriteriaObj]()
    
    let userDefaultsManager = UserDefaultsManager()
    
    let findUtil = FindUtil()
    
    //Fonction pour retourner à la view anterior
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Fonction pour enregistrer le discipline
    @IBAction func actionAddDiscipline(_ sender: UIButton) {
        let description = String(describing: textFieldDescription.text!).trimmingCharacters(in: .whitespaces)
        
        if description != ""  && criteriasDiscipline.count > 0
         {
            
            var sum = 0
            for criteria in criteriasDiscipline
            {
                sum += Int(criteria.weight)!
            }
            
            if sum != 100
            {
                let alertController = UIAlertController(title: "Evaluation+", message: "The weight of criteria must be 100 in the total", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
            else
            {
                let disciplineObj = DisciplineObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, criterias: criteriasDiscipline)
                
                disciplines.append(disciplineObj)
                
                let data = NSKeyedArchiver.archivedData(withRootObject: disciplines);
                userDefaultsManager.setKey(theValue: data as AnyObject, key: "disciplines")
                
                tableViewDisciplines.reloadData()
                
                textFieldDescription.text = ""
                
                textFieldDescription.resignFirstResponder()
            }
         }
         else
         {
            let alertController = UIAlertController(title: "Evaluation+", message: "Please, put the description and select unless one criteria", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
         }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.tableViewDisciplines {
            count = disciplines.count
        }
        
        if tableView == self.tableViewCriterias {
            count =  criterias.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        if tableView == self.tableViewDisciplines {
            let cell = tableView.dequeueReusableCell(withIdentifier: "discipline", for: indexPath) as? DisciplineTableViewCell
            
            let description = disciplines[indexPath.row].desc
            cell?.labelDescriptionDiscipline.text = description
            
            return cell!
        }
        else if tableView == self.tableViewCriterias
        {
           let  cell = tableView.dequeueReusableCell(withIdentifier: "criteria", for: indexPath) as? CriteriaTableViewCell
          
            let criteria = criterias[indexPath.row].desc
            let weight = criterias[indexPath.row].weight
            
            cell?.labelDescriptionCriteria.text = "\(criteria) - \(weight) / 100"
            
            return cell!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewCriterias
        {
            let criteria = criterias[indexPath.row]
            criteriasDiscipline.append(criteria)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewCriterias
        {
            let id = criterias[indexPath.row].id
            let index = indexCriteriasDiscipline(id: id!)
            criteriasDiscipline.remove(at: index)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            
            let id = disciplines[indexPath.row].id
            if !findUtil.findEleveByDiscipline(id:id!)
            {
                disciplines.remove(at: indexPath.row)
                tableViewDisciplines.deleteRows(at: [indexPath], with: .automatic)
                
                let data = NSKeyedArchiver.archivedData(withRootObject: disciplines);
                userDefaultsManager.setKey(theValue: data as AnyObject, key: "disciplines")
            }
            else
            {
                let message = "Assignment associated with a student. Cannot be deleted"
                let alertController = UIAlertController(title: "Evaluation+", message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //Fonction pour obtenir le position de la criteria dans le tableau selon une indentification
    func indexCriteriasDiscipline(id: Int64) -> Int
    {
        for index in 0..<criteriasDiscipline.count
        {
            if criteriasDiscipline[index].id == id
            {
                return index
            }
        }
        return -1
    }
    
    override func viewDidLoad() {
        
        viewTop.layer.borderColor = UIColor(rgb: 0x8d8b8b).cgColor
        viewTop.layer.borderWidth = 2
        
        tableViewDisciplines.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewCriterias.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        if userDefaultsManager.doesKeyExist(theKey: "criterias") {
            let data = userDefaultsManager.getData(theKey: "criterias")
            criterias = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [CriteriaObj])!
        }
        
        if userDefaultsManager.doesKeyExist(theKey: "disciplines") {
            let data = userDefaultsManager.getData(theKey: "disciplines")
            disciplines = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [DisciplineObj])!
        }
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
