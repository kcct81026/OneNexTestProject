//
//  CategoryCVCell.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var category : Category? = nil {
        didSet{
            if let category = category {
                title.text = "\(category.title)"
                img.image = category.icon
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
