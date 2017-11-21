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
    
    var criteriaObj: CriteriaObj!
    
    var criterias = [CriteriaObj]()
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddCriteria(_ sender: UIButton) {
      //  let criteriaTableViewCell = CriteriaTableViewCell()
        let description = textViewDescriptionCriteria.text
        let ponctuation = Int(textFieldPonctuationCriteria.text!)
        
        let criteriaObj = CriteriaObj(id: Int64(Date().timeIntervalSince1970 * 1000), desc: description, ponctuation: ponctuation)
        
        criterias.append(criteriaObj)
        
        tableViewCriteria.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "criteria")!
        
       /* let name = eleves[indexPath.row].name
        cell.textLabel?.text = name*/
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
