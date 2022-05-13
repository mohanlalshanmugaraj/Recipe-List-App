//
//  NaviagationLinkView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI

struct NaviagationLinkView: View {
    @Binding var isPressed : Bool
    @State var sampleName = ""
    var body: some View {
        VStack{
            Spacer()
            Text(sampleName)
            Spacer()
            Button("Take me Back"){
                isPressed = false
            }
            Spacer()
            Spacer()
            Spacer()
        }
    
    }
}

struct NaviagationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NaviagationLinkView(isPressed: .constant(true), sampleName: "hello")
    }
}

