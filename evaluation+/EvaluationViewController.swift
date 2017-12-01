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
    @IBOutlet weak var labelScoreCriteria: UILabel!
    
}

class EvaluationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var labelEleve: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var pickerDisciplines: UIPickerView!
    
    @IBOutlet weak var tableViewEvaluation: UITableView!
    
    var eleveObj: EleveObj!
    var scoreEleve = Float(0.0);
    
    var pickerData = [String]()
    
    var countCriteria = 0
    var indexDiscipline = 0
    
    var userDefaultsManager = UserDefaultsManager()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCriteria
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evaluation", for: indexPath) as! EvaluationTableViewCell
        
        let desc = eleveObj.disciplines[indexDiscipline].criterias[indexPath.row].desc
        let weight = eleveObj.disciplines[indexDiscipline].criterias[indexPath.row].weight
        let ponctuation = Float(eleveObj.disciplines[indexDiscipline].criterias[indexPath.row].ponctuation)!
        
        cell.labelDescriptionCriteria.text = "\(desc) - \(weight) / 100"
        cell.slidePonctuationCriteria.value = ponctuation
        cell.slidePonctuationCriteria.tag = indexPath.row
        cell.slidePonctuationCriteria.addTarget(self, action:#selector(EvaluationViewController.sliderValueDidChange(_:)), for: .valueChanged)
        
          switch cell.slidePonctuationCriteria.value {
            case 0:
                cell.labelScoreCriteria.text = "Ruim"
                break
            case 25:
                cell.labelScoreCriteria.text = "Regular"
                break
            case 50:
                cell.labelScoreCriteria.text = "Bom"
                break
            case 75:
                cell.labelScoreCriteria.text = "Otimo"
                break
            default:
                cell.labelScoreCriteria.text = "Excelente"
         }
        
        return cell
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initTableView(row: row)
    }
    
    func initTableView(row: Int)
    {
        countCriteria = eleveObj.disciplines[row].criterias.count
        indexDiscipline = row
        tableViewEvaluation.reloadData()
        setScore()
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        let roundedValue = round(sender.value / 25) * 25
        sender.value = roundedValue
       
        eleveObj.disciplines[indexDiscipline].criterias[sender.tag].ponctuation = String(sender.value)
 
        setScore()
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
        
        let alertController = UIAlertController(title: "Evaluation+", message: "Evaluation done", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        viewTop.layer.borderColor = UIColor(rgb: 0x8d8b8b).cgColor
        viewTop.layer.borderWidth = 2
        
        pickerDisciplines.dataSource = pickerData as? UIPickerViewDataSource
        pickerDisciplines.setValue(UIColor.white, forKey: "textColor")

        for dicipline in eleveObj.disciplines
        {
            pickerData.append(dicipline.desc)
        }
        
        initTableView(row: 0)
        
        labelEleve.text = eleveObj.name
        
        setScore()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setScore()
    {
        var sum = Float(0.0);
        
        for criteria in eleveObj.disciplines[indexDiscipline].criterias
        {
            sum += regleTrois(ponctuation: criteria.ponctuation, weight: criteria.weight)
        }
        
        labelScore.text = "\(sum) / 100"
        
        tableViewEvaluation.reloadData()
    }
    
    func regleTrois(ponctuation:String, weight: String) -> Float
    {
        let p = Float(ponctuation)
        let w = Float(weight)
        
        let r = (w! * p!) / 100

        return Float(r)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

