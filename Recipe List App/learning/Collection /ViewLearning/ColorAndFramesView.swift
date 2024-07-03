//
//  ColorAndFramesView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 11/05/22.
//

import SwiftUI

struct ColorAndFramesView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .top, endPoint: .bottom)
            
//            Color.red
//                //.frame(width: 200, height: 200, alignment: .center)
//                .frame(minWidth : 200, maxWidth: .infinity,maxHeight: 200)
            
            //frame(width : 200 , height : 200)
        }
    }
}

struct ColorAndFramesView_Previews: PreviewProvider {
    static var previews: some View {
        ColorAndFramesView()
    }
}
