//
//  TextFieldExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 11/05/22.
//

import SwiftUI

struct TextFieldExample: View {
    @State var name = ""
    @State var percentage = 0
    @State var mark = 0.00
    @FocusState private var amountIsFocued : Bool
    
    var tipPercentage = [10,15,20,25,0]
    var body: some View {
        Form {
            Section {
                TextField("name ", text :$name ).keyboardType(.default)
                    .focused($amountIsFocued)
                
                Picker("Number PercentAge",selection: $percentage){
                    ForEach (tipPercentage, id: \.self){
                        Text($0, format: .percent)
                    }
                }.pickerStyle(.segmented)
                TextField("name ", value : $mark, format:.currency(code: Locale.current.currencyCode ?? "USD" )  )
                
            }
        }.toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Button("Done") {
                    amountIsFocued = false
                }
            }
        }
    }
}

struct TextFieldExample_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldExample()
    }
}
