//
//  ArrowTBCell.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 27/10/2023.
//

import UIKit

class ArrowTBCell: UITableViewCell {
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        arrowView.layer.cornerRadius = 5
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
