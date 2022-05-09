//
//  ExamplePicker.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 05/05/22.
//

import SwiftUI

struct ExamplePicker: View {
    @State var selectedIndex = 1;
    
    var body: some View {
        VStack{
            Picker("Tap me ",selection: $selectedIndex) {
                Text("option 1").tag(1)
                Text("option 2").tag(2)
                Text("option 3").tag(3)
            }.pickerStyle(MenuPickerStyle())
            Text("you 've selected: \(selectedIndex)")
        }
        
    }
}

struct ExamplePicker_Previews: PreviewProvider {
    static var previews: some View {
        ExamplePicker()
    }
}
