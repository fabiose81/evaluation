//
//  ElevesViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-16.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class ElevesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewEleves: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "evaluation", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "evaluation" ,
            let evaluationViewController = segue.destination as? EvaluationViewController ,
            let indexPath = tableViewEleves.indexPathForSelectedRow {
               let eleveObj = EleveObj(id: indexPath.row, name: "Teste")
               evaluationViewController.eleveObj = eleveObj
        }
    }
    
    @IBAction func back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
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
