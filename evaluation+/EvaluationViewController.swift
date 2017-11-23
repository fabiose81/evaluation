//
//  ViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDescriptionCriteria: UILabel!
    @IBOutlet weak var slidePonctuationCriteria: UISlider!
    
}

class EvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var labelEleve: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    var eleveObj: EleveObj!
    var scoreEleve = Float(0.0);
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eleveObj.score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evaluation", for: indexPath) as! EvaluationTableViewCell
        
        let desc = eleveObj.score[indexPath.row].desc
        
        cell.labelDescriptionCriteria.text = desc
        cell.slidePonctuationCriteria.value = Float(eleveObj.score[indexPath.row].ponctuation)!
        cell.slidePonctuationCriteria.tag = indexPath.row
        cell.slidePonctuationCriteria.addTarget(self, action:#selector(EvaluationViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
        return cell
    }
    
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        let roundedValue = round(sender.value / 25) * 25
        sender.value = roundedValue
        
        eleveObj.score[sender.tag].ponctuation = String(sender.value)
   
        xxx()
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        var data = userDefaultsManager.getData(theKey: "eleves")
        var eleves = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [EleveObj])!
        
        let index = eleves.index(where: { (eleve) -> Bool in
            eleve.id == eleveObj.id
        })
        
        eleves[index!] = eleveObj
        
        data = NSKeyedArchiver.archivedData(withRootObject: eleves);
        userDefaultsManager.setKey(theValue: data as AnyObject, key: "eleves")
    }
    
    
    override func viewDidLoad() {
        if userDefaultsManager.doesKeyExist(theKey: "criterias") {
            let data = userDefaultsManager.getData(theKey: "criterias")
            let criterias = (NSKeyedUnarchiver.unarchiveObject(with: data ) as? [CriteriaObj])!
            
            if eleveObj.score.count == 0
            {
                eleveObj.score = criterias
            }
            else if eleveObj.score.count < criterias.count
            {
                for criteria in criterias {
                    let found = findByCriteria(id: criteria.id)
                    if (found == false){
                        eleveObj.score.append(criteria)
                    }
                }
            }else
            {
                for index in 0..<eleveObj.score.count
                {
                    let found = findEleve(id: eleveObj.score[index].id, criterias: criterias)
                    if (found == false){
                        eleveObj.score.remove(at: index)
                    }
                }
            }
        }
        
        xxx()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func xxx(){
        labelEleve.text = eleveObj.name
        var sum = Float(0.0);
        for score in eleveObj.score
        {
            sum += Float(score.ponctuation)!
        }
        
        scoreEleve = sum * 100 / Float((eleveObj.score.count * 100))
        labelScore.text = "\(String(Int(scoreEleve)))/100"
    }
    
    func findByCriteria(id: Int64) -> Bool{
        for eleve in eleveObj.score {
            if eleve.id == id {
                return true
            }
        }
        return false;
    }

    func findEleve(id: Int64, criterias: [CriteriaObj]) -> Bool{
        let _criterias = criterias
        for criteria in _criterias {
            if criteria.id == id {
                return true
            }
        }
        return false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

