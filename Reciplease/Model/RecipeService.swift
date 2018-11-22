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
}

// MARK: - Network Call
extension RecipeService {
    func getSearchRecipe(callback: @escaping (String?, SearchRecipe?) -> Void) {
        searchRecipeAPI.bodyText = Constant.ingredients.joined(separator: "+")
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
