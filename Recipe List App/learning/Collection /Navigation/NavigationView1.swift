//
//  NavigationView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI

struct NavigationView1: View {
    @State private var isPresented = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NavigationLink(isActive: $isPresented) {
                        NaviagationLinkView(isPressed: $isPresented, sampleName: "it is first page")
                    } label: {
                        Text("Next Page")
                    }
                    Spacer()
                    Button("Click me"){
                        isPresented = true
                    }
                    
                    
                    
                    
                    //                NavigationLink {
                    //                    NaviagationLinkView(sampleName: "1-st page")
                    //                } label: {
                    //                    Text("next Page")
                    //                }
                }
            }.navigationTitle("View 1").navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView1()
    }
}
