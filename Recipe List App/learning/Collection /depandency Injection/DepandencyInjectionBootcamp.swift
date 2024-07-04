//
//  DepandencyInjectionBootcamp.swift
//  Recipe List App
//
//  Created by mohanlal on 04/07/24.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL
// 2. Can't customize the init!
// 3. Can't swap out service

struct PostsModels : Decodable, Identifiable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModels], Error>
}

class ProductionDataSource : DataServiceProtocol {
//    static let instance = ProductionDataSource() // singleton

    let url : URL
    
    init (_url : URL) {
        url = _url
    }
    
    func getData() -> AnyPublisher<[PostsModels], Error> {
            URLSession.shared.dataTaskPublisher(for: url)
                .map({ $0.data })
                .decode(type: [PostsModels].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
}

class MockDataService : DataServiceProtocol {
    
    let testData : [PostsModels]
    
    init(_testData : [PostsModels]?) {
        testData = _testData ?? [
            PostsModels(userId: 1, id: 1, title: "One", body: "one"),
            PostsModels(userId: 2, id: 2, title: "Two", body: "two"),
            PostsModels(userId: 3, id: 3, title: "Three", body: "three")
        ]
    }
    func getData() -> AnyPublisher<[PostsModels], any Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
        
    }
    
    
}

class Depandencies {
    let dataService : DataServiceProtocol
    
    init(_dataService : DataServiceProtocol) {
        self.dataService = _dataService
    }
}


class DepandencyInjectionViewModel : ObservableObject {
    @Published var dataArray : [PostsModels] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService : DataServiceProtocol
    
    init(dataSercice : DataServiceProtocol) {
        self.dataService = dataSercice
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
                .sink { _ in
                    
                } receiveValue: { [weak self] returnedPosts in
                    self?.dataArray = returnedPosts
                }
                .store(in: &cancellables)

        }
}

struct DepandencyInjectionBootcamp: View {
    @StateObject private var vm : DepandencyInjectionViewModel
    
    init(dataSercice : DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DepandencyInjectionViewModel(dataSercice: dataSercice))
    }
    
    
    var body: some View {
           ScrollView {
               VStack {
                   ForEach(vm.dataArray) { post in
                       Text(post.title)
                   }
               }
           }
       }
}

#Preview {
      DepandencyInjectionBootcamp(dataSercice: ProductionDataSource(_url: URL(string : "https://jsonplaceholder.typicode.com/posts")!)) 
    
    
    
    
//    DepandencyInjectionBootcamp(dataSercice: MockDataService(_testData: [
//        PostsModels(userId: 1, id: 1, title: "One", body: "one"),
//        PostsModels(userId: 2, id: 2, title: "Two", body: "two"),
//        PostsModels(userId: 3, id: 3, title: "Three", body: "three")
//    ]))
}
