//
//  NewMockDataService_Tests.swift
//  Recipe List AppTests
//
//  Created by mohanlal on 04/07/24.
//

import XCTest
@testable import Recipe_List_App
import Combine

final class NewMockDataService_Tests: XCTestCase {
    var cancelable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items : [String]? = nil
        let items2 : [String]? = []
        let items3 : [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = NewMockDateService(items: items)
        let dataService2 = NewMockDateService(items: items2)
        let dataService3 = NewMockDateService(items: items3)
        
        // then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = NewMockDateService(items: nil)
        
        // When
        var items : [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = NewMockDateService(items: nil)
        
        // When
        var items : [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
                expectation.fulfill()
            }
            .store(in: &cancelable)

        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMockDateService(items: [])
        
        // When
        var items : [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
                expectation.fulfill()
            }
            .store(in: &cancelable)

        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    

}
