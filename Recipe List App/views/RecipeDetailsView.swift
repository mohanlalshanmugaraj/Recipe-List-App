//
//  RecipeDetailsView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 23/04/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    var recipe:Recipe
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment:.leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.bottom,.top],5)
                    
                    ForEach(recipe.ingredients){ item in
                        Text("•" + item.name)
                    }
                }.padding(.horizontal)
                
                
                //divder
                Divider()
                
                //direation
                
                VStack(alignment: .leading){
                    Text("Direation")
                        .font(.headline)
                        .padding([.bottom,.top],5)
                    
                    ForEach(0..<recipe.directions.count, id:\.self){intex in
                        Text(String(intex+1) + "• "+recipe.directions[intex]).padding(.bottom,5)
                    }
                    
                    
                }.padding(.horizontal)
                
            }
          //  .padding([.leading,.trailing],10)
            
        }
        .navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let model = RecipeViewModel()
        RecipeDetailsView(recipe: model.recipes[0])
    }
}
