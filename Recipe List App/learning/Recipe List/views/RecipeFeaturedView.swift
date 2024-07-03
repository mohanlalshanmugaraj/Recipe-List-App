//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 02/05/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    @EnvironmentObject var model:RecipeViewModel
    @State var isDetailsViewShowing = false
    
    var body: some View {
    
        
        VStack(alignment : .leading,spacing: 0){
            Text("Featured Recipe").bold().padding(.top,40).padding(.leading).font(.largeTitle)
    GeometryReader{ geo in
    TabView{
        //loop through each recipes
        ForEach (0..<model.recipes.count){index in
            
            //only show those that be featured
            if model.recipes[index].featured {
                
                Button(action: {
                    //click position
                    
                    self.isDetailsViewShowing = true
                },label : {
                    ZStack {
                    Rectangle()
                            .foregroundColor(.white)
                    
                    VStack(spacing : 0){
                        Image(model.recipes[index].image)
                            .resizable()
                            .clipped()
                        Text(model.recipes[index].name)
                            .padding(5)
                    }
                }
                }).sheet(isPresented : $isDetailsViewShowing){
                    //show recipe details view
                    RecipeDetailsView(recipe: model.recipes[index])
                    
                }.buttonStyle(PlainButtonStyle()).frame(width: geo.size.width - 40, height: geo.size.height-100, alignment: .leading)
                    .cornerRadius(15)
                    //.shadow(radius: 10)
                    .shadow(color: Color(.sRGB,red : 0,green : 0 ,blue: 0,opacity: 0.5), radius: 10, x: -5, y: 5)
            }
        }
    }.tabViewStyle(PageTabViewStyle(indexDisplayMode : .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
            
            VStack(alignment: .leading,spacing : 10){
                Text("Preparation Time :")
                    .font(.headline)
                Text("1 hour")
                Text("highlights")
                    .font(.headline)
                Text("Healthly , hearty")
            }.padding([.leading,.bottom])
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView().environmentObject(RecipeViewModel())
    }
}
