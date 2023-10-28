//
//  IrregularRectangleShapeView.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit

class IrregularShapeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: 100, y: 0)
        let bottomRight = CGPoint(x: 250, y: 250)
        let bottomLeft = CGPoint(x: 0, y: 250)

        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: bottomRight)
        path.addLine(to: bottomLeft)
        path.close()

        let customColor = UIColor(red: 247/255, green: 148/255, blue: 28/255, alpha: 1.0)
        customColor.setFill()
        path.fill()
    }
}
