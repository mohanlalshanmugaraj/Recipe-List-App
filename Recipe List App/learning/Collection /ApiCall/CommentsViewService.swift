//
//  CommentsViewService.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import Foundation

enum DemoError : Error {
    case BadUrl
    case NoData
    case DecodeingError
}


protocol CommonViewSeriviceDelegate {
    func getComments(completion : @escaping(Result<[CommentsModel], NetWorkError>) -> Void)
}

class CommentsViewService : CommonViewSeriviceDelegate {
    
    func getComments(completion : @escaping(Result<[CommentsModel], NetWorkError>) -> Void) {
        RestApiClient.getComments(completion: completion)
    }
    
    
    
    func getCommentsList(completion : @escaping(Result<[CommentsModel]?, DemoError>) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments")else {
            return completion(.failure(.BadUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let  data = data ,error == nil else{
                return completion(.failure(.NoData))
            }
            
            
            let commentResponse = try? JSONDecoder().decode([CommentsModel].self, from: data)
            
            if let commentResponse = commentResponse {
                completion(.success(commentResponse))
            }else{
                return completion(.failure(.NoData))
            }
            
        }.resume()
    }
}
