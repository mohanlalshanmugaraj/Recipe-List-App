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
    
    static func getPortion(ingredient:Ingredients,recipeServings:Int,tergetServings:Int) -> String{
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholeportion = 0
        if ingredient.num != nil {
            //get a single service size by multiplaying denominator by the recipe service
            denominator *= recipeServings
            
            //get a terget portion by multiplying numerator by target services
            numerator *= tergetServings
            
            //reduce fraction by gratest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator,denominator)
            numerator /= divisor
            denominator /= divisor
            
            //get the whole portion if numerator > denominator
            if numerator > denominator {
                //calculator the whole portions
                wholeportion = numerator / denominator
                
                //calculat the remaining portions
                numerator = numerator % denominator
                
                //assign to portion string
                portion += String(wholeportion)
            }
            
            
            //express the remainder as a fraction
            if numerator > 0 {
                //assign the remainder as fraction to the portion string
                portion += wholeportion > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
           
        }
        
        if let unit = ingredient.unit {
            //calculat appropriate suffix
            
            
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
        }
        
        
        return portion
    }
}
