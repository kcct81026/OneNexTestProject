//
//  HomeViewModel.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import Combine

enum HomeViewState{
    case sendToggle
    case refresh
    

}


class HomeViewModel {
    // variable
    var items: [HomeViewControllerSectionType] = [
        .Slider,
        .Promotion,
        .Announcement,
        .NewLetter,
    ]
    var isScrollup = false 
    private let articleModel :  ArticleModel!
    
    var categoryList : [CategoryVO] = []
    var articleList : [ArticleVO] = []

    
    init(articleModel : ArticleModel = ArticleModelImpl.shared){
        self.articleModel = articleModel
    }

    
    var viewState: PassthroughSubject<HomeViewState, Never> = .init()

    
    func handleDropDownArrow(){
        
        isScrollup.toggle()
        self.viewState.send(.sendToggle)

    }
    
    func fetchArticleList(){
        articleModel.getArticles(){ [weak self](result) in
            guard let self = self else { return }
            switch result{
            case .success(let resultData):
                self.articleList = resultData.articles
                self.viewState.send(.refresh)

            case .failure(let message):
                print(message)
            }
        }
    }

    func fetchArticleCategory(){
        articleModel.getArticleCategory(){ [weak self](result) in
            guard let self = self else { return }
            switch result{
            case .success(let resultData):
                self.categoryList = resultData.categories
                self.viewState.send(.refresh)
            case .failure(let message):
                print(message)
            }
        }
    }
}
