//
//  CollectionViewCellModel.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit
import Combine

class CollectionCellViewModel {
    var cellType: HomeViewControllerSectionType = .Slider
    var cellCount: Int = 0
    
    init(cellType: HomeViewControllerSectionType,articleModel : ArticleModel = ArticleModelImpl.shared) {
        self.cellType = cellType
        self.articleModel = articleModel

        setupCellType()
       
    }
    
    private let articleModel :  ArticleModel!
    var viewState: PassthroughSubject<HomeViewState, Never> = .init()

  
  
    
    private func setupCellType() {
        switch cellType {
        case .Promotion:
            cellCount = 5
        case .NewLetter:
            cellCount = 5
        case .Slider:
            cellCount = 5
        case .Announcement:
            cellCount = announcementList.count
        }
    }
   
   
}



