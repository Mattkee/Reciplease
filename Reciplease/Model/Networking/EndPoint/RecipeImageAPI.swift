//
//  RecipeImageAPI.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 11/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

struct RecipeImageAPI: EndPointType {
    var newUrl: URL
    
    var baseURL: URL {
        return newUrl
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask {
        return .request
    }
}
