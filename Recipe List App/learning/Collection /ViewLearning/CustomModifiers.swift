//
//  CustomModifiers.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 13/05/22.
//

import SwiftUI




extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Title : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CustomModifiers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .titleStyle()
          //  .modifier(Title())
    }
}

struct CustomModifiers_Previews: PreviewProvider {
    static var previews: some View {
        CustomModifiers()
    }
}
