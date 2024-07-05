//
//  UnitTestingView.swift
//  Recipe List App
//
//  Created by mohanlal on 04/07/24.
//

/*
 1. Unit Tests
 - test the business logic in your app
 
 2. UI Tests
 - tests the UI of your app
 */

import SwiftUI

struct UnitTestingView: View {
    @StateObject private var vm : UnitTestingViewModel
    
    init(_isPremium : Bool) {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: _isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingView(_isPremium: true)
}
