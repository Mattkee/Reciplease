//
//  RecipeService.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import Alamofire

protocol DisplayAlert {
    func showAlert(title: String, message: String)
}

class RecipeService {
    private var recipeAPI = RecipeAPI()
    private var router : Router<RecipeAPI, Recipe>
    private var imageRouter : Router<RecipeImageAPI, Data>
    
    init(router: Router<RecipeAPI, Recipe> = Router<RecipeAPI, Recipe>(alamofireRequest: AlamofireRequest()), imageRouter: Router<RecipeImageAPI, Data> = Router<RecipeImageAPI, Data>(alamofireRequest: AlamofireRequest())) {
        self.router = router
        self.imageRouter = imageRouter
    }
}

// MARK: - Network Call
extension RecipeService {
    func getRecipe(callback: @escaping (String?, Recipe?) -> Void) {
        recipeAPI.bodyText = Constant.ingredients.joined(separator: "+")
        router.request(recipeAPI, Recipe.self) { (error, object) in
                guard error == nil else {
                    callback(error, nil)
                    return
                }
                print("c'est ok")
                let recipe = object as? Recipe
                callback(nil, recipe)
        }
    }
//    func getRecipeImage(newURL: String, callback: @escaping (String?, RecipeImage?) -> Void) {
//        guard let url = URL(string: newURL) else {
//            callback(nil, nil)
//            return
//        }
//        let recipeImageAPI = RecipeImageAPI(newUrl: url, httpMethod: .get)
//        imageRouter.request(recipeImageAPI, Data.self) { (error, object) in
//            guard error == nil else {
//                callback(error, nil)
//                return
//            }
//            print("image ok")
//            guard let image = object as? Data else {
//                callback(error, nil)
//                return
//            }
//            let recipeImage = RecipeImage(image: image)
//            callback(nil, recipeImage)
//        }
//    }
}
