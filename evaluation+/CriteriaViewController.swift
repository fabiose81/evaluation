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
    @IBOutlet weak var labelWeightCriteria: UILabel!
    
}

class CriteriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textFieldDescriptionCriteria: UITextField!
    @IBOutlet weak var textFieldWeightCriteria: UITextField!
    
    @IBOutlet weak var tableViewCriteria: UITableView!

    var criterias = [CriteriaObj]()
     
    let userDefaultsManager = UserDefaultsManager()
    
    let findUtil = FindUtil()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddCriteria(_ sender: UIButton) {
        let description = String(describing: textFieldDescriptionCriteria.text!).trimmingCharacters(in: .whitespaces)
        let weight = String(describing: textFieldWeightCriteria.text!).trimmingCharacters(in: .whitespaces)
        
        if description != "" && weight != ""
        {
            let criteriaObj = CriteriaObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, weight: weight, ponctuation: "0")
            
            criterias.append(criteriaObj)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: criterias);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "criterias")
            
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
        textFieldWeightCriteria.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "criteria", for: indexPath) as! CriteriaTableViewCell
       
        let desc = criterias[indexPath.row].desc
        let weight = criterias[indexPath.row].weight
        
        cell.labelDescriptionCriteria.text = desc
        cell.labelWeightCriteria.text = String(weight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            let id = criterias[indexPath.row].id
            if !findUtil.findDisciplineByCriteria(id:id!)
            {
                criterias.remove(at: indexPath.row)
                tableViewCriteria.deleteRows(at: [indexPath], with: .automatic)
                
                let data = NSKeyedArchiver.archivedData(withRootObject: criterias);
                userDefaultsManager.setKey(theValue: data as AnyObject, key: "criterias")
            }
            else
            {
                print("criteria vinculado a uma disciplina")
            }
        }
    }
    
    override func viewDidLoad() {
        if userDefaultsManager.doesKeyExist(theKey: "criterias") {
            let data = userDefaultsManager.getData(theKey: "criterias")
            criterias = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [CriteriaObj])!
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
