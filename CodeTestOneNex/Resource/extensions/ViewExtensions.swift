//
//  ViewExtensions.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = maskPath.cgPath
        self.layer.mask = shapeLayer
    }
}


