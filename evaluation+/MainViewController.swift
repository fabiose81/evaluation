//
//  MainViewController.swift
//  evaluation+
//
//  Created by eleves on 2017-11-30.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!

    override func viewDidLoad() {
        viewTop.layer.borderColor = UIColor(rgb: 0x8d8b8b).cgColor
        viewTop.layer.borderWidth = 2
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
