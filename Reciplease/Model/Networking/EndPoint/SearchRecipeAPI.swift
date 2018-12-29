//
//  SearchRecipeAPI.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Currency API from yummly
struct SearchRecipeAPI: EndPointType {

    var parameters: Parameters = [("_app_id", Constant.yummlyAPIID), ("_app_key", Constant.yummlyAPIKey)]

    var baseURL: URL {
        return URL(string: "http://api.yummly.com/v1/api")!
    }
    
    var path: String {
        return "/recipes"
    }
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: parameters)
    }
}
