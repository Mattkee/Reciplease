//
//  IngredientService.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 30/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

class IngredientService {
    func clear() {
        Constant.ingredients = [String]()
    }
    
    func ingredienttext(_ text: String) -> [String] {
        var list = text.components(separatedBy: ", ")
        list.forEach { element in
            if element.contains(",") {
                let test = element.components(separatedBy: ",")
                list.append(contentsOf: test)
                list.removeAll(where: {$0 == element})
            }
        }
        return list
    }
    
    func addText(_ text : String) {
        if text.contains(",") {
            let finalTest = ingredienttext(text)
            Constant.ingredients.append(contentsOf: finalTest)
        } else {
            Constant.ingredients.append(text)
        }
    }
    
    func removeIngredient(at index: Int) {
        Constant.ingredients.remove(at: index)
    }
}
