//
//  Recipe_List_AppApp.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 18/04/22.
//

import SwiftUI

@main
struct Recipe_List_AppApp: App {
    var body: some Scene {
        WindowGroup {
//            RecipeTabView()
//            LoginScreen()
//            ToastScreen()
            DepandencyInjectionBootcamp(dataSercice: ProductionDataSource(_url: URL(string : "https://jsonplaceholder.typicode.com/posts")!))
        }
    }
}
