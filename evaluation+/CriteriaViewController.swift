//
//  CriteriaViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-21.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class CriteriaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDescriptionCriteria: UILabel!
    @IBOutlet weak var labelPonctuationCriteria: UILabel!
    
}

class CriteriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textFieldDescriptionCriteria: UITextField!
    @IBOutlet weak var textFieldPonctuationCriteria: UITextField!
    
    @IBOutlet weak var tableViewCriteria: UITableView!
    
    var disciplineObj: DisciplineObj!
    
    var disciplines: [DisciplineObj]!
     
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddCriteria(_ sender: UIButton) {
        let description = String(describing: textFieldDescriptionCriteria.text!).trimmingCharacters(in: .whitespaces)
        let ponctuation = String(describing: textFieldPonctuationCriteria.text!).trimmingCharacters(in: .whitespaces)
        
        if description != "" && ponctuation != ""
        {
            let criteriaObj = CriteriaObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, ponctuation: ponctuation)
            
            disciplineObj.criterias.append(criteriaObj)
            
            setDiscipline(_discipline: disciplineObj)
            
            tableViewCriteria.reloadData()
        }
        else
        {
            let alertController = UIAlertController(title: "Evaluation+", message: "Please, fill the fields", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
        hideKeyboard()
    }
    
    @IBAction func actionHideKeyboard(_ sender: UIButton) {
        hideKeyboard()
    }
    
    func hideKeyboard()
    {
        textFieldDescriptionCriteria.resignFirstResponder()
        textFieldPonctuationCriteria.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplineObj.criterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "criteria", for: indexPath) as! CriteriaTableViewCell
       
        let desc = disciplineObj.criterias[indexPath.row].desc
        let ponctuation = disciplineObj.criterias[indexPath.row].ponctuation
        
        cell.labelDescriptionCriteria.text = desc
        cell.labelPonctuationCriteria.text = String(ponctuation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            disciplineObj.criterias.remove(at: indexPath.row)
            
            setDiscipline(_discipline: disciplineObj)
            
            tableViewCriteria.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func setDiscipline(_discipline: DisciplineObj){
        for index in 0..<disciplines.count{
            if disciplines[index].id == _discipline.id {
                disciplines[index] = _discipline
                break
            }
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: disciplines);
        userDefaultsManager.setKey(theValue: data as AnyObject, key: "disciplines")
    }
    
    override func viewDidLoad() {
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
