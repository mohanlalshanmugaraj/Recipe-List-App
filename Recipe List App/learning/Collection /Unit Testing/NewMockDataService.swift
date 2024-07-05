//
//  NewMockDataService.swift
//  Recipe List App
//
//  Created by mohanlal on 04/07/24.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion : @escaping(_ items : [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDateService : NewDataServiceProtocol {
    let items : [String]
    
    init(items: [String]?) {
        self.items = items ??  [
        "ONE", "TWO", "THREE"]
    }
    
    func downloadItemsWithEscaping(completion : @escaping(_ items : [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ items in
                guard !items.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return items
            })
            .eraseToAnyPublisher()
    }
}
