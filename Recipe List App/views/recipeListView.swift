//
//  ContentView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 18/04/22.
//

import SwiftUI

struct recipeListView: View {
    @ObservedObject var recipeViewModel = RecipeViewModel();
    
    
    var body: some View {
        NavigationView{
            List(recipeViewModel.recipes){ r in
                
                NavigationLink(
                    destination: (RecipeDetailsView(recipe: r)),
                    label:{
                    HStack(spacing:20.0){
                        Image(r.image).resizable().scaledToFill().frame(width: 50, height: 50, alignment: .center).clipped().cornerRadius(5)
                        Text(r.name)
                    }
                })
                
                
               
            }.navigationTitle("All Recipts")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        recipeListView()
    }
}
