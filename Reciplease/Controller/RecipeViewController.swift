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
    var favorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if favorite {
            favoriteButton.image = UIImage(imageLiteralResourceName: "star-yellow-small")
        }
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
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(imageLiteralResourceName: "star-yellow-small") {
            sender.image = UIImage(imageLiteralResourceName: "star-white-small")
            guard let recipeName = recipeWithImage?.recipeName else {
                return
            }
            Constant.favorites.removeAll(where: { $0.recipeName == recipeName })
        } else {
            sender.image = UIImage(imageLiteralResourceName: "star-yellow-small")
            guard let recipe = recipeWithImage else {
                return
            }
            Constant.favorites.append(recipe)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
