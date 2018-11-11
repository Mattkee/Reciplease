//
//  RecipeService.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import Alamofire

class RecipeService {
    private var recipeAPI = RecipeAPI()
    private var router : Router<RecipeAPI, Recipe>
    
    init(router: Router<RecipeAPI, Recipe> = Router<RecipeAPI, Recipe>(alamofireRequest: AlamofireRequest())) {
        self.router = router
    }
    var ingredients = ["onion", "soup"]

    func prepareIngredients(_ allIngredients: [String]) -> String {
        var bodyText = ""
        for ingredient in allIngredients {
            if ingredient == allIngredients[0] {
                bodyText = ingredient
            } else {
                bodyText = bodyText + "+" + ingredient
            }
        }
        return bodyText
    }
}

// MARK: - Network Call
extension RecipeService {
    func getRecipe(callback: @escaping (String?, Recipe?) -> Void) {
        recipeAPI.bodyText = prepareIngredients(ingredients)
        router.request(recipeAPI, Recipe.self) { (error, object) in
            DispatchQueue.main.async {
                guard error == nil else {
                    callback(error, nil)
                    return
                }
                print("c'est ok")
                let recipe = object as? Recipe
                callback(nil, recipe)
            }
        }
    }
    func getRecipeImage(callback: @escaping (String?, [Data]) -> Void) {
        
    }
}
