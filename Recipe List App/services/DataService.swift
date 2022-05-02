//
//  DataService.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 18/04/22.
//

import Foundation
class DataService{
    
    static func getLocalData() -> [Recipe]{
        //perse local json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        guard pathString != nil else{
            return [Recipe]()
        }
            //create a url object
            let url = URL(fileURLWithPath: pathString!)
            do{
                
                let data = try Data(contentsOf: url)
                
                //decode the data of decoder object
                let decoder = JSONDecoder()
                
                //json decoder object
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                //add the unique ids
                for recipe in recipeData{
                    recipe.id = UUID();
                    
                    //add unique id to ingredients of the id
                    for i in recipe.ingredients {
                        i.id = UUID()
                    }
                }
                
                //retuen the recipes
                return recipeData
                
            }catch{
                print(error)
            }
        
        return [Recipe]()
    }
}
