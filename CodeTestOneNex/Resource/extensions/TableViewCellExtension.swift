//
//  TableViewCellExtension.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 27/10/2023.
//

import Foundation
import UIKit

@objc
extension UITableViewCell {
    
    static var identifier: String{
        String(describing: self)
    }
}


extension UITableView{
    func registerForCell(identifier:String){
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier:String, indexPath:IndexPath)->T{
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else{
            return UITableViewCell() as! T
        }
        return cell
    }
}


