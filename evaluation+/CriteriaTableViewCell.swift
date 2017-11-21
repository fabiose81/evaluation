//
//  CriteriaTableViewCell.swift
//  evaluation+
//
//  Created by eleves on 2017-11-21.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class CriteriaTableViewCell: UITableViewCell {

    @IBOutlet weak var textViewDescriptionCriteria: UITextView!
    @IBOutlet weak var labelPonctuationCriteria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
