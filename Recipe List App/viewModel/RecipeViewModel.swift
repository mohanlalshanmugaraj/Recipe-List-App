//
//  RecipeViewModel.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 18/04/22.
//

import Foundation
class RecipeViewModel: ObservableObject{
    @Published var recipes = [Recipe]()
    init(){
       //create a instance of data model
        self.recipes = DataService.getLocalData()
    }
}
