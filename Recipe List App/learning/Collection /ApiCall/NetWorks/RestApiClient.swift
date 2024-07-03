//
//  RestApiClient.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import Foundation
import Alamofire

enum NetWorkError : Error {
    case BadUrl
    case NoData
    case DecodeingError
    case ApiError(String)
}


class RestApiClient {
    static func request<T: Codable>(type: T.Type,
                                    rounter: ApiRounter,completion:@escaping(Result<T,NetWorkError>) -> Void) {
        AF.request(rounter).response { response in
            let result = response.result
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.NoData))
                    return
                }
                
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.DecodeingError))
                    return
                }
                
                completion(.success(obj))
            case .failure(let error):
                completion(.failure(.ApiError(error.localizedDescription)))
            }
        }
    }
    
    
    static func getComments(completion : @escaping(Result<[CommentsModel], NetWorkError>) -> Void) {
        return request(type: [CommentsModel].self ,
                       rounter: ApiRounter.getComments,
                       completion: completion)
    }
}




