//
//  ArticleModel.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
protocol ArticleModel{
    func getArticles(completion : @escaping (OneNexResult<ArticleResponse>) -> Void)
    func getArticleCategory(completion : @escaping (OneNexResult<CategoryResponse>) -> Void)
    
}

class ArticleModelImpl : BaseModel, ArticleModel{
    
    static let shared = ArticleModelImpl()
    
    private override init() {}

    func getArticles(completion : @escaping (OneNexResult<ArticleResponse>) -> Void){
        networkAgent.getArticles( completion: completion)

    }
    
    func getArticleCategory(completion : @escaping (OneNexResult<CategoryResponse>) -> Void){
        networkAgent.getArticleCategory( completion: completion)

    }
    
    
}
