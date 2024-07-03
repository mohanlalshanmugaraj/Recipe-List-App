//
//  GeoMetryReader.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 02/05/22.
//

import SwiftUI

struct GeoMetryReader: View {
    var body: some View {
       
        VStack(spacing: 0){
                GeometryReader{ geo in
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width : geo.size.width/4, height: geo.size.height,alignment: .center)
                    .onTapGesture {
                        print("clicked green")
                    }
                    
                //    Rectangle().foregroundColor(.brown)
                  //      .frame(width: 100, height: 100, alignment: .center)
                       // .padding([.leading,.top],20)
                     //   .offset(x:30,y:30)
                }.padding([.leading,.top],30)
                GeometryReader{geo in
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width : geo.size.width/4, height: geo.size.height/8,alignment: .center)
                        .onTapGesture {
                            print("clicked red")
                        }
                    
                }
        }
    }
}

struct GeoMetryReader_Previews: PreviewProvider {
    static var previews: some View {
        GeoMetryReader()
    }
}
