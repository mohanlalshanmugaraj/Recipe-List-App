//
//  ButtomAndImage.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 11/05/22.
//

import SwiftUI

struct ButtomAndImage: View {
    var body: some View {
        VStack {
          //  Button (E)
            
           // Image(systemName: "pencil")
            
            
            Button("Delete Selection",action: deleteMethod)
            
            Button("Button 1"){}.buttonStyle(.bordered)
            
            Button("Button 2", role : .destructive){}.buttonStyle(.bordered)
            
            Button("Button 3"){}.buttonStyle(.borderedProminent)
            
            Button("Button 4" , role : .destructive){}.buttonStyle(.borderedProminent)
                .tint(.green)
            
        }
    }
    
    func deleteMethod(){
        print("now deleteing")
    }
}

struct ButtomAndImage_Previews: PreviewProvider {
    static var previews: some View {
        ButtomAndImage()
    }
}
