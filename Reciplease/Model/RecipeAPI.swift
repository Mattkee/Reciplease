//
//  RecipeAPI.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 05/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Currency API from Fixer.io
struct RecipeAPI {
    
    var baseURL: URL {
        return URL(string: "http://api.yummly.com/v1/api")!
    }
}
