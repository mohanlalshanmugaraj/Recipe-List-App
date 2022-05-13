//
//  ViewModelExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI

struct ViewModelExample: View {
   @ObservedObject var viewModel = ObservedAndStateViewModel()
    var body: some View {
        VStack{
            Text(viewModel.text).padding(.bottom)
            Button("click me"){
                viewModel.text = UUID().uuidString
            }
        }
    }
}


class ObservedAndStateViewModel : ObservableObject {
    @Published var text :String  = "Hello Text"
}

struct ViewModelExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelExample()
    }
}
