//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 15/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    var recipeWithImage: RecipeWithImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipeIngredient.text = ""
        if let recipeWithImage = recipeWithImage {
            recipeName.text = recipeWithImage.recipeName
            recipeRating.text = recipeWithImage.recipeRating
            recipeTime.text = recipeWithImage.recipeTime
            recipeWithImage.recipeIngredients.forEach { ingredient in
                if ingredient == recipeWithImage.recipeIngredients[0] {
                    recipeIngredient.text = "- " + ingredient
                } else {
                    recipeIngredient.text = recipeIngredient.text + "\n" + "- " + ingredient
                }
            }
            recipeImage.image = recipeWithImage.recipeImage
        }
    }
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeIngredient: UITextView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
