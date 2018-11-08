//
//  RecipeAPI.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Currency API from Fixer.io
struct RecipeAPI: EndPointType {

    var bodyText = ""

    var baseURL: URL {
        return URL(string: "http://api.yummly.com/v1/api")!
    }
    
    var path: String {
        return "/recipes"
    }
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask {
        let q = bodyText
        return .requestParameters(bodyParameters: nil, urlParameters: ["_app_id": Constant._app_id, "_app_key": Constant._app_key, "q":q])
    }
}
