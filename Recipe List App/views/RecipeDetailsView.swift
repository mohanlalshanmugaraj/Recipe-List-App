//
//  RecipeDetailsView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 23/04/22.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    @State var ingSelectedIndex = 2
    
    var recipe:Recipe
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                //MARK : SERVING SIZE PICKER
                VStack(alignment : .leading){
                    Text("Select Your Serving size: ")
                    Picker("",selection: $ingSelectedIndex){
                        Text("2").tag(2)
                            .foregroundColor(.black)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }.pickerStyle(SegmentedPickerStyle())
                        .frame(width: 160)
                }.padding()
               
                
                VStack(alignment:.leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.bottom,.top],5)
                    
                    ForEach(recipe.ingredients){ item in
                        Text("• " + RecipeViewModel.getPortion(ingredient: item, recipeServings: recipe.servings, tergetServings: ingSelectedIndex) + " " + item.name.lowercased())
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
