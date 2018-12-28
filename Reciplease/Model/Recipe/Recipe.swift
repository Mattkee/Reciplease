//
//  Recipe.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 19/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

struct Recipe : Decodable {

    let totalTime : String
    let images : [Images]
    let name : String
    let id : String
    let ingredientLines : [String]
    let rating : Int
    let source : Source

    struct Images : Decodable {
        let hostedSmallUrl : String
    }
    struct Source : Decodable {
        let sourceRecipeUrl : String
    }
}
