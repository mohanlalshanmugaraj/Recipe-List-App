//
//  EnvironmentObjectExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI

struct EnvironmentObjectExample1: View {
    @ObservedObject var viewModel = RecipeViewModel()
    @State var userName = ""
    var body: some View {
        
        NavigationView {
            VStack {
                Text("it is a view 1")
                    .padding(.bottom)
                TextField("Enter User Name ",text : $viewModel.userName)
                    .font(.title)
                    .frame(width: 200, height: 49, alignment: .center)
                
//                NavigationLink {
//                    EnvironmentObjectExample2()
//                } label: {
//                    Text("Click me move to next page")
//                }
//
            }
        }.environmentObject(viewModel)
    }
}


struct EnvironmentObjectExample_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectExample1()
    }
}
