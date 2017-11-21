//
//  ElevesViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit


class ElevesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textFieldEleveName: UITextField!
    
    @IBOutlet weak var tableViewEleves: UITableView!
    
    var eleves = [EleveObj]()
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddEleve(_ sender: UIButton) {
        let name = textFieldEleveName.text
        let score = [0,0,0,0,0]
        let eleveObj = EleveObj(id: Int64(Date().timeIntervalSince1970 * 1000), name: name, score: score)
        
        eleves.append(eleveObj)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: eleves);
        userDefaultsManager.setKey(theValue: data as AnyObject, key: "eleves")
        
        tableViewEleves.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eleves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let name = eleves[indexPath.row].name
        cell.textLabel?.text = name
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "evaluation", sender: self)
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
        if userDefaultsManager.doesKeyExist(theKey: "eleves") {
            let data = userDefaultsManager.getData(theKey: "eleves")
            eleves = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [EleveObj])!
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
