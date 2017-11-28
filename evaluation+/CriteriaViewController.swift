//
//  CriteriaViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-21.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class CriteriaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textViewDescriptionCriteria: UITextView!
    @IBOutlet weak var labelPonctuationCriteria: UILabel!
    
}

class CriteriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textViewDescriptionCriteria: UITextView!
    @IBOutlet weak var textFieldPonctuationCriteria: UITextField!
    
    @IBOutlet weak var tableViewCriteria: UITableView!
    
    var criterias = [CriteriaObj]()
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddCriteria(_ sender: UIButton) {
        let description = String(describing: textViewDescriptionCriteria.text!).trimmingCharacters(in: .whitespaces)
        let ponctuation = String(describing: textFieldPonctuationCriteria.text!).trimmingCharacters(in: .whitespaces)
        
        
        if description != "" && ponctuation != ""
        {
            let criteriaObj = CriteriaObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, ponctuation: ponctuation)
            
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
        textViewDescriptionCriteria.resignFirstResponder()
        textFieldPonctuationCriteria.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "criteria", for: indexPath) as! CriteriaTableViewCell
       
        let desc = criterias[indexPath.row].desc
        let ponctuation = criterias[indexPath.row].ponctuation
        
        cell.textViewDescriptionCriteria.text = desc
        cell.labelPonctuationCriteria.text = String(ponctuation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            criterias.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: criterias);
            userDefaultsManager.setKey(theValue: data as AnyObject, key: "criterias")
            
            tableViewCriteria.deleteRows(at: [indexPath], with: .automatic)
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
