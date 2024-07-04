//
//  ProtocolsBootcamp.swift
//  Recipe List App
//
//  Created by mohanlal on 04/07/24.
//

import SwiftUI

struct DefaultColorTheme : ColorThemeProtocol {
    let primary : Color = .blue
    let secoundary : Color = .white
    let tertiary : Color = .gray
}

struct AlternativeColorTheme : ColorThemeProtocol {
    let primary : Color = .red
    let secoundary : Color = .white
    let tertiary : Color = .green
}

protocol ColorThemeProtocol {
    var primary : Color { get }
    var secoundary : Color { get }
    var tertiary : Color { get }
}

protocol ButtonTextProtocol {
    var buttonText : String { get}
    func buttonPress()
}

class DefalutDataSource : ButtonTextProtocol {
    var buttonText : String = "Protocals are awesome!"
    
    func buttonPress() {
    }
}

class AlternativeDataSource : ButtonTextProtocol {
    func buttonPress() {
    }
    
    var buttonText : String = "Protocals are lame!"

}



struct ProtocolsBootcamp: View {
//    let colorTheme : DefaultColorTheme = DefaultColorTheme()
//    let colorTheme : AlternativeColorTheme = AlternativeColorTheme()
    let colorTheme : ColorThemeProtocol
    let dataSource : ButtonTextProtocol
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secoundary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPress()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: AlternativeColorTheme(), dataSource: AlternativeDataSource())
}
