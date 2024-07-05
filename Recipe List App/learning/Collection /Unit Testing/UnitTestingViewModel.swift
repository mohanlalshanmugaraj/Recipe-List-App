//
//  UnitTestViewModel.swift
//  Recipe List App
//
//  Created by mohanlal on 04/07/24.
//

import Foundation
import SwiftUI
import Combine

class UnitTestingViewModel : ObservableObject {
    @Published var isPremium : Bool
    @Published var dataArray : [String] = []
    @Published var selectedItem : String? = nil
    let dataService : NewDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService : NewDataServiceProtocol = NewMockDateService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item : String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item : String) {
        if let x = dataArray.first(where: { $0 == item}) {
            selectedItem = x
        }else {
            selectedItem = nil
        }
    }
    
    func saveItem(item : String) throws {
        guard !item.isEmpty else {
            throw DataError.nodata
        }
        
        if let x = dataArray.first(where: { $0 == item}) {
            print("Save item here!!! \(x)")
        }else {
            throw DataError.itemNotFound
        }
        
    }
    
    enum DataError : LocalizedError {
        case nodata
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
   
    func downloadItemsWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnItems in
                self?.dataArray = returnItems
            }
            .store(in: &cancellables)

    }
    
    
}
