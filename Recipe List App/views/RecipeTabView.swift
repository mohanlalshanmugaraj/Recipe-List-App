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
            Text("Featurad View").tabItem({
                VStack{
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            })
            
            recipeListView().tabItem({
                VStack{
                    Image(systemName: "list.bullet")
                    Text("list")
                }
            })
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
