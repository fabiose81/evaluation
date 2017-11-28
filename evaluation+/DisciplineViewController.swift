//
//  DisciplineViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-28.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class DisciplineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var tableViewDisciplines: UITableView!
    
    var disciplines = [DisciplineObj]()
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddDiscipline(_ sender: UIButton) {
        let description = String(describing: textFieldDescription.text!).trimmingCharacters(in: .whitespaces)
        
        if description != ""
         {
            let criterias = [CriteriaObj]()
            let disciplineObj = DisciplineObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, criterias: criterias)
         
            disciplines.append(disciplineObj)
         
            let data = NSKeyedArchiver.archivedData(withRootObject: disciplines);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "disciplines")
         
            tableViewDisciplines.reloadData()
         
            textFieldDescription.resignFirstResponder()
         }
         else
         {
            let alertController = UIAlertController(title: "Evaluation+", message: "Please, put the description", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
         }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let description = disciplines[indexPath.row].description
        cell.textLabel?.text = description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "criteria", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            disciplines.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: disciplines);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "disciplines")
            
            tableViewDisciplines.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "criteria" ,
            let criteriaViewController = segue.destination as? CriteriaViewController ,
            let indexPath = tableViewDisciplines.indexPathForSelectedRow {
            let disciplineObj = disciplines[indexPath.row]
            criteriaViewController.disciplineObj = disciplineObj
        }
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
