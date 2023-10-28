//
//  PromotinCVCell.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import UIKit

class PromotinCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomview: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setuiForPromotion(data : CategoryVO?){
        if let catogry = data {
            dateLbl.text = customDateString(dateString: catogry.createdAt)
            titleLbl.text = catogry.name
        }
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
       
        let systemFont = UIFont.systemFont(ofSize: 18.0)

        // Create a bold version of the system font
        let boldSystemFont = UIFont(descriptor: systemFont.fontDescriptor.withSymbolicTraits(.traitBold) ?? systemFont.fontDescriptor, size: 18.0)
        titleLbl.font = boldSystemFont
        
    }
    
    func setuiForNewLetters(data: ArticleVO?){
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        img.layer.borderColor = UIColor.gray.cgColor
        img.layer.borderWidth = 0.5
        
        if let catogry = data {
            dateLbl.text = customDateString(dateString: catogry.createdAt).uppercased()
            titleLbl.text = catogry.title
        }
    
    
        let fontSize: CGFloat = 16.0
        let font = UIFont.systemFont(ofSize: fontSize)
        titleLbl.font = font
    }
    
    


}
