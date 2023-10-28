//
//  PageControlView.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit

class RectanglePageControl: UIPageControl {
    let rectangleSize = CGSize(width: 20, height: 10)
    let rectangleSpacing: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Calculate the total width required for all rectangles
        let totalWidth = CGFloat(numberOfPages) * (rectangleSize.width + rectangleSpacing) - rectangleSpacing

        // Calculate the starting x-coordinate for the first rectangle
        var x = (bounds.size.width - totalWidth) / 2

        for (index, view) in subviews.enumerated() {
            if let rectangle = view as? UIView {
                if index == currentPage {
                    rectangle.frame.size = CGSize(width: rectangleSize.width + 10, height: rectangleSize.height)
                } else {
                    rectangle.frame.size = rectangleSize
                }

                rectangle.layer.cornerRadius = 3 // You can adjust this value to change the corner radius of the rectangles.
                rectangle.frame.origin.x = x
                x += rectangle.frame.size.width + rectangleSpacing
            }
        }
    }
}
