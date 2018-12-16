//
//  Constant.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 08/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

struct Constant {
    // MARK: - General Constant
    static let titleAlert = "Echec Appel réseau"
//
//    // MARK: - Change Constant
//    static let fixerAPIKey = "d08ec4ef9bde66e8a89fafb3527c76f7"
//
//    // MARK: - Translate Constant
//    static let googleAPIKey = "AIzaSyBsL5HR_zdFcFdqZWSTyHhu--xxMrI-gCw"
//
//    // MARK: - Weather Constant
//    static var allCity = ["New York","Quimper","Nantes"]
    static let yummlyAPIID = "11c8630f"
    static let yummlyAPIKey = "fc109c0cebd13ea423026392a404ea49"

    static let cookingChoice = ["American", "Italian", "Asian", "Mexican", "Southern & Soul Food", "French", "Southwestern", "Barbecue", "Indian", "Chinese", "Cajun & Creole", "English", "Mediterranean", "Greek", "Spanish", "German", "Thai", "Moroccan", "Irish", "Japanese", "Cuban", "Hawaiin", "Swedish", "Hungarian", "Portugese"]
    static let diets = ["Lacto vegetarian", "Ovo vegetarian", "Pescetarian", "Vegan", "Vegetarian"]
    static let alergies = ["Dairy", "Egg", "Gluten", "Peanut", "Seafood", "Sesame", "Soy", "Sulfite", "Tree Nut", "Wheat"]
    
    static var cookingParameters = [String]()
    static var dietsParameters = [String]()
    static var alergiesParameters = [String]()

    static var ingredients = [String]()

    static var favorites = [Recipe]()
}
