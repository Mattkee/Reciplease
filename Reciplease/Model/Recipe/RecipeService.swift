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
    private var searchRecipeAPI = SearchRecipeAPI()
    private var recipeAPI = RecipeAPI()
    private var router : Router<SearchRecipeAPI, SearchRecipe>
    private var recipeRouter : Router<RecipeAPI, Recipe>

    init(router: Router<SearchRecipeAPI, SearchRecipe> = Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: AlamofireRequest()), recipeRouter: Router<RecipeAPI, Recipe> = Router<RecipeAPI, Recipe>(alamofireRequest: AlamofireRequest())) {
        self.router = router
        self.recipeRouter = recipeRouter
    }

    func addParameters() -> [(String, Any)] {
        var parameters = [(String, Any)]()
        let cookingParameters = Constant.cookingParameters
        let dietsParameters = Constant.dietsParameters
        let alergiesParameters = Constant.alergiesParameters
        
        if !cookingParameters.isEmpty {
            cookingParameters.forEach { parameter in
                parameters.append(("allowedCuisine[]", parameter))
            }
        }
        if !dietsParameters.isEmpty {
            dietsParameters.forEach { parameter in
                parameters.append(("allowedDiet[]", parameter))
            }
        }
        if !alergiesParameters.isEmpty {
            alergiesParameters.forEach { parameter in
                parameters.append(("allowedAllergy[]", parameter))
            }
        }
        return parameters
    }
}

// MARK: - Network Call
extension RecipeService {
    func getSearchRecipe(callback: @escaping (String?, SearchRecipe?) -> Void) {
        let q = Constant.ingredients.joined(separator: "+")
        let parameters = addParameters()
        searchRecipeAPI.parameters.append(("q", q))
        if !parameters.isEmpty {
            searchRecipeAPI.parameters.append(contentsOf: parameters)
        }
        router.request(searchRecipeAPI, SearchRecipe.self) { (error, object) in
            guard error == nil else {
                callback(error, nil)
                return
            }
            let searchRecipe = object as? SearchRecipe
            callback(nil, searchRecipe)
        }
    }
    
    func getRecipe(_ recipeId: String, callback: @escaping (String?, Recipe?) -> Void) {
        recipeAPI.recipeID = recipeId
        recipeRouter.request(recipeAPI, Recipe.self) { (error, object) in
            guard error == nil else {
                callback(error, nil)
                return
            }
            let recipe = object as? Recipe
            callback(nil, recipe)
        }
    }
}
