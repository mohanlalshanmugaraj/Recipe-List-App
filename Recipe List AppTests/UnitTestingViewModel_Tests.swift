//
//  UnitTestingViewModel_Tests.swift
//  Recipe List AppTests
//
//  Created by mohanlal on 04/07/24.
//

import XCTest
@testable import Recipe_List_App
import Combine

// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure : test_[struct or class]_[variable or function]_[expected result]
// Testing Structure : Given, When, Then


final class UnitTestingViewModel_Tests: XCTestCase {
    
    var viewModel : UnitTestingViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium : Bool = true
        
        //When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium : Bool = false
        
        //When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        //Given
        let userIsPremium : Bool = Bool.random()
        
        //When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            //Given
            let userIsPremium : Bool = Bool.random()
            
            //When
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
         //Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        
         //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount : Int = 1000
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        //XCTAssertGreaterThanOrEqual
        //XCtAssertLessThen
        //XCTAssertLessThenOrEqual
        
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString() {
        //Given
       let vm = UnitTestingViewModel(isPremium: Bool.random())
       
       // When
       vm.addItem(item: "")
       
       //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString2() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
       
       // When
       vm.addItem(item: "")
       
       //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeStartWithNil() {
        //Given
       
       // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())

       //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_dataArray_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
       
       // When
        vm.selectItem(item: UUID().uuidString)

       //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_dataArray_selectedItem_shouldBeSelected() {
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
       
       // When
        let uuid = UUID().uuidString
        vm.addItem(item: uuid)
        vm.selectItem(item: uuid)

       //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, uuid)
    }
    
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount : Int = Int.random(in: 1..<100)
        var itemsArray : [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        XCTAssertEqual(vm.selectedItem, randomItem)
        
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowErrorBeSelected_itemNotFound() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount : Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            _ = UUID().uuidString
            vm.addItem(item:  UUID().uuidString)
        }
      
        // then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
        }
        
        
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowErrorBeSelected_NoData() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount : Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item:  UUID().uuidString)
        }
      
        // then
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw item not found") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.nodata)
        }
    }
    
    func test_UnitTestingViewModel_SaveItem_shouldBeSave() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount : Int = Int.random(in: 1..<100)
        var itemsArray : [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
    
        // Then
        XCTAssertFalse(randomItem.isEmpty)
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
    }
    
    func test_UnitTestingViewModel_DownloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 5 secounds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returneditems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
    
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_DownloadWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 5 secounds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returneditems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadItemsWithCombine()
        
    
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    

}
