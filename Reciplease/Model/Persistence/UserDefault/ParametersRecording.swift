//
//  ParametersRecording.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 30/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

class ParametersRecording {
    // MARK: - Keys for UserDefault object
    private struct Keys {
        static let cookingParameters = "cookingParameters"
        static let dietsParameters = "dietsParameters"
        static let alergiesParameters = "alergiesParameters"
    }
    // MARK: - Chosen parameters
    static var cookingParameters : [String] {
        get {
            guard let cooking = UserDefaults.standard.object(forKey: Keys.cookingParameters) as? [String] else {
                return []
            }
            return cooking
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cookingParameters)
        }
    }

    static var dietsParameters : [String] {
        get {
            guard let diets = UserDefaults.standard.object(forKey: Keys.dietsParameters) as? [String] else {
                return []
            }
            return diets
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.dietsParameters)
        }
    }

    static var alergiesParameters : [String] {
        get {
            guard let alergies = UserDefaults.standard.object(forKey: Keys.alergiesParameters) as? [String] else {
                return []
            }
            return alergies
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.alergiesParameters)
        }
    }
}
