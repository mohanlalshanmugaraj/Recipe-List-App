//
//  AppStorageExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI


enum SettingKeys {
    static let notifications = "notifications"
    static let dailyVideoLimit = "dailyVideoLimit"
}


struct AppStorageExample: View {
    
    @AppStorage(SettingKeys.notifications, store: .standard) var notifications: Bool = false
    @AppStorage(SettingKeys.dailyVideoLimit) var dailyVideoLimit: Double = 1
    var body: some View {
        Form {
            Section {
                Toggle("notification",isOn: $notifications)
            }
            
            Section {
                Stepper(value: $dailyVideoLimit, in: 1...5){
                    Text("Daily video Limit is \(dailyVideoLimit,specifier: "%.f")")
                }
            }
        }
    }
}

struct AppStorageExample_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageExample()
    }
}
