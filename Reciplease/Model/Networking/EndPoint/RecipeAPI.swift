//
//  RecipeAPI.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 19/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

struct RecipeAPI: EndPointType {
    
    var recipeID = ""
    var baseURL: URL {
        return URL(string: "http://api.yummly.com/v1/api/recipe/")!
    }
    
    var path: String {
        return recipeID
    }
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: ["_app_id": Constant.yummlyAPIID, "_app_key": Constant.yummlyAPIKey])
    }
}
