//
//  ElevesViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class EleveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNameEleve: UILabel!
    
}

class ElevesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var textFieldEleveName: UITextField!
    
    @IBOutlet weak var tableViewEleves: UITableView!
    @IBOutlet weak var tableViewDisciplines: UITableView!
    
    var eleves = [EleveObj]()
    var disciplines = [DisciplineObj]()
    var disciplinesEleve = [DisciplineObj]()
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddEleve(_ sender: UIButton) {
        let name = String(describing: textFieldEleveName.text!).trimmingCharacters(in: .whitespaces) 
        
        if name != "" && disciplinesEleve.count > 0
        {
            let eleveObj = EleveObj(id: Int64(Date().timeIntervalSince1970 * 1000), name: name, disciplines: disciplinesEleve)
            
            eleves.append(eleveObj)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: eleves);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "eleves")
            
            tableViewEleves.reloadData()
            
            textFieldEleveName.resignFirstResponder()
        }
        else
        {
            let alertController = UIAlertController(title: "Evaluation+", message: "Please, put the name and select unless one discipline", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.tableViewEleves {
            count = eleves.count
        }
        
        if tableView == self.tableViewDisciplines {
            count =  disciplines.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        if tableView == self.tableViewEleves
        {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "eleve", for: indexPath) as? EleveTableViewCell
            
            let name = eleves[indexPath.row].name
            
            cell?.labelNameEleve.text = name
            
            return cell!
        }
        else if tableView == self.tableViewDisciplines
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "discipline", for: indexPath) as? DisciplineTableViewCell
            
            let description = disciplines[indexPath.row].desc
            cell?.labelDescriptionDiscipline.text = description
            
            return cell!
        }
        return cell!
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewEleves
        {
            self.performSegue(withIdentifier: "evaluation", sender: self)
        }
        else if tableView == self.tableViewDisciplines
        {
            let discipline = disciplines[indexPath.row]
            disciplinesEleve.append(discipline)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewDisciplines
        {
           let id = disciplines[indexPath.row].id
           let index = indexDisciplinesEleve(id: id!)
           disciplinesEleve.remove(at: index)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            eleves.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: eleves);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "eleves")
            
            tableViewEleves.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "evaluation" ,
            let evaluationViewController = segue.destination as? EvaluationViewController ,
            let indexPath = tableViewEleves.indexPathForSelectedRow {
               let eleveObj = eleves[indexPath.row]
               evaluationViewController.eleveObj = eleveObj
        }
    }
    
    @IBAction func back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
   
    override func viewDidLoad() {
        
        viewTop.layer.borderColor = UIColor(rgb: 0x8d8b8b).cgColor
        viewTop.layer.borderWidth = 2
        
        tableViewEleves.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewDisciplines.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        if userDefaultsManager.doesKeyExist(theKey: "eleves") {
            let data = userDefaultsManager.getData(theKey: "eleves")
            eleves = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [EleveObj])!
        }
        
        if userDefaultsManager.doesKeyExist(theKey: "disciplines") {
            let data = userDefaultsManager.getData(theKey: "disciplines")
            disciplines = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [DisciplineObj])!
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func indexDisciplinesEleve(id: Int64) -> Int
    {
        for index in 0..<disciplinesEleve.count
        {
            if disciplinesEleve[index].id == id
            {
                return index
            }
        }
        return -1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
