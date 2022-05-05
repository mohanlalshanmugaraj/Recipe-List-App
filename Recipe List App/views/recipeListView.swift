//
//  ContentView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 18/04/22.
//

import SwiftUI

struct recipeListView: View {
    
    @EnvironmentObject var model:RecipeViewModel
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment : .leading){
                Text("All Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top,40)
                    .font(.largeTitle)
                
                ScrollView{
                    LazyVStack(alignment : .leading){
                        ForEach(model.recipes){ r in
                            
                            NavigationLink(
                                destination: (RecipeDetailsView(recipe: r)),
                                label:{
                                    HStack(spacing:20.0){
                                        Image(r.image).resizable().scaledToFill().frame(width: 50, height: 50, alignment: .center).clipped().cornerRadius(5)
                                        Text(r.name).foregroundColor(.black)
                                    }
                                })
                            
                            
                            
                        }.navigationBarHidden(true)
                    }.padding(.leading)
                }
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        recipeListView().environmentObject(RecipeViewModel())
    }
}
