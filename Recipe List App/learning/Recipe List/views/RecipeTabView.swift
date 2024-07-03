//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 24/04/22.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView{
            RecipeFeaturedView().tabItem({
                VStack{
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            }).environmentObject(RecipeViewModel())
            
            recipeListView().tabItem({
                VStack{
                    Image(systemName: "list.bullet")
                    Text("list")
                }
            }).environmentObject(RecipeViewModel())
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
