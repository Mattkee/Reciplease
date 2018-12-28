//
//  RecipeView.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 28/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

class RecipeView: UIView {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    @IBOutlet var ratingImage: [UIImageView]!
    

    var recipe: Recipe! {
        didSet {
            recipeName.text = recipe.name
            recipeTime.text = recipe.totalTime
            let image = UIImage.recipeImage(recipe.images[0].hostedSmallUrl)
            self.recipeImage.image = image
            ratingDisplay(String(recipe.rating), ratingImage)
            
        }
    }
    var favoriteRecipe: FavoriteRecipe! {
        didSet {
            recipeName.text = favoriteRecipe.name
            recipeTime.text = favoriteRecipe.totalTime
            if let image = favoriteRecipe.image {
                self.recipeImage.image = UIImage.recipeImage(image)
            } else {
                self.recipeImage.image = UIImage(imageLiteralResourceName: "breakfast")
            }
            guard let rating = favoriteRecipe.rating else {
                return
            }
            ratingDisplay(rating, ratingImage)
        }
    }
}
