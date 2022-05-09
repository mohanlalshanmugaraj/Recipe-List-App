//
//  TestingView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 07/05/22.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        VStack{
            Text("hi mohanlal")
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .frame(width: 200.0, height: 40.0)
            
            Text(Date().addingTimeInterval(600),style: .relative)
        }
        
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
