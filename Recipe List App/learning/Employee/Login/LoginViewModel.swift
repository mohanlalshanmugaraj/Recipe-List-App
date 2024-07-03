//
//  LoginViewModel.swift
//  Recipe List App
//
//  Created by mohanlal on 02/07/24.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var userName = ""
    @Published var password = ""
    @Published var navigateToEmployee = false
    
    func validateLogin() -> Bool {
        if !userName.isEmpty && !userName.isEmpty {
            if userName == "Mohan" && password == "123" {
                return true
            }
        }
        return false
    }
    
    func navigateToEmployeeSelection() {
        if validateLogin() {
            navigateToEmployee = true
        }
    }
}
