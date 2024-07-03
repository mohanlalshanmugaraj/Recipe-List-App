//
//  FormView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 11/05/22.
//

import SwiftUI

struct FormView: View {
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                
                Section {
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
            }.navigationBarTitle("Swift UI")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
