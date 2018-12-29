//
//  SearchRecipe.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 06/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

// MARK: - Decodable object
struct SearchRecipe : Decodable {
    let matches : [Matches]
    
    struct Matches: Decodable {
        
        let id : String
        let ingredients : [String]
        let recipeName : String
        let smallImageUrls : [String]
        let totalTimeInSeconds : Int
        let rating : Int
    }
}
