//
//  alertDialogExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 12/05/22.
//

import SwiftUI

struct alertDialogExample: View {
    @State private var showingAleart = false
    
    var body: some View {
        Button("show Alert"){
            showingAleart = true
        }.alert("Important message", isPresented: $showingAleart){
            Button("delete", role: .destructive){}
            Button("cancel",role : .cancel){}
        } message : {
            Text("do you delete this product")
        }
    }
}

struct alertDialogExample_Previews: PreviewProvider {
    static var previews: some View {
        alertDialogExample()
    }
}
