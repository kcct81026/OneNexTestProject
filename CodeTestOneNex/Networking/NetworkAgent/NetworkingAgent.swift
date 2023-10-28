//
//  NetworkingAgent.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import Alamofire

protocol OneNextNetworkAgentProtocol {
    
    func getArticles(completion : @escaping (OneNexResult<ArticleResponse>) -> Void)
    func getArticleCategory(completion : @escaping (OneNexResult<CategoryResponse>) -> Void)
    
}


struct OneNexNetworkAgent : OneNextNetworkAgentProtocol{
    
    static let shared = OneNexNetworkAgent()
    
    private init(){}
    
    let headers: HTTPHeaders = [
        "Authorization":  AppConstants.api_key
    ]

    
    func getArticles(completion : @escaping (OneNexResult<ArticleResponse>) -> Void){
        AF.request(OneNexEndPoint.getArticles, headers: headers)
            .responseDecodable(of: ArticleResponse.self) { response in
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(response, error, OneNexCommonResponseError.self)))
                }
                
            }
    }
    
    func getArticleCategory( completion : @escaping (OneNexResult<CategoryResponse>) -> Void){
        AF.request(OneNexEndPoint.getArticleCategory, headers: headers)
            .responseDecodable(of: CategoryResponse.self) { response in
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(response, error, OneNexCommonResponseError.self)))
                    
                }
                
            }
    }
    
    /*
     Network Error - Differnet Scenarios
     - JSON Serialization Error
     - Wrong URL Path
     - Incorrect Method
     - Missing Credentials
     - 4xx
     - 5xx
     */
    
    // 3 - Customized Error Body
    fileprivate func handleError < T, E: OneNexErrorModel>(
        _ response: DataResponse<T, AFError>,
        _ error: (AFError),
        _ errorBodyType : E.Type ) -> String
    {
        var respBody : String = ""
        
        var serverErrorMessage : String?
        
        var errorBody : E?
        if let respData = response.data{
            respBody = String(data: respData, encoding: .utf8) ?? "empty response body"
            errorBody = try? JSONDecoder().decode( errorBodyType, from: respData)
            serverErrorMessage = errorBody?.message
        }
        
        /// 2 - Extract debug info
        let respCode : Int = response.response?.statusCode ?? 0
        
        let sourcePath = response.request?.url?.absoluteString ?? "no url"
        
        /// 1 - Essential debug Info
        print(
            """
            ========================
            URL
            -> \(sourcePath)

            Status
            -> \(respCode)
            
            Body
            -> \(respBody)

            Underlying Error
            -> \(error.underlyingError!)
            
            Error Description
            -> \(error.errorDescription!)
            ========================
            """
        )
        
        /// 4 - Client dispaly
        return serverErrorMessage ?? error.errorDescription ?? "undefined"
    }
    
}
