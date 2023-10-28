//
//  OneNexEndPoint.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import Alamofire


enum OneNexEndPoint : URLConvertible, URLRequestConvertible{
    case getArticles
    case getArticleCategory

    
    private var baseURL : String{
        return AppConstants.BASEURL
    }

    func asURL() throws -> URL {
        return url
    }
    
    func asURLRequest() throws -> URLRequest {

        let request = URLRequest(url: try asURL())
        return request
    }

    var url: URL{
        let urlComponents = NSURLComponents(
            string: baseURL.appending(apiPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? apiPath)
        )
        if (urlComponents?.queryItems == nil){
            urlComponents!.queryItems = []
        }
        
        
//        urlComponents!.queryItems!.append(contentsOf: [URLQueryItem(name: "api-key", value: AppConstants.api_key)])
//    
        return urlComponents!.url!
    }
    
    private var apiPath : String{
        switch self{
        case .getArticles :
            return "/api/articles"
        case .getArticleCategory:
            return "/api/articles/categories"
        
        }
    }
    
}
