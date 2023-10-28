//
//  CollectionViewCellExtension.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit

//MARK: UICollectionViewCell Extension
extension UICollectionViewCell{
    static var identifier: String{
        String(describing: self)
    }
}

extension UICollectionView{
    func registerForCell(identifier:String){
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UICollectionViewCell>(identifier:String, indexPath: IndexPath)->T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else{
            return UICollectionViewCell() as! T
        }
        return cell
    }
}
