//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 15/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    var recipe: Recipe?
    var favoriteRecipe: FavoriteRecipe?
    let recipeService = RecipeService()
    var recipeID : String?
    var ingredients = [String]()
    var preparation = [String]()
    var displayAlertDelegate: DisplayAlert?

    var favorite : Bool {
        if recipeID != nil {
            let favorite = FavoriteRecipe.all.contains(where: { $0.id == recipeID })
            return favorite
        } else {
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeView.setupRating(recipeView.ratingStackView, &recipeView.ratingImage)
        favoriteButton.setImage(#imageLiteral(resourceName: "add-favorite"), for: .normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .selected)
        getDirectionsButton.layer.cornerRadius = 10
    }

    override func viewWillAppear(_ animated: Bool) {
        if favorite {
            favoriteButton.isSelected = true
            let favorite = FavoriteRecipe.all.first(where: { $0.id == recipeID })
            self.favoriteRecipe = favorite
            displayFavorite()
        } else {
            guard let id = recipeID else {
                return
            }
            searchRecipe(id)
        }
    }

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeView: RecipeView!
    
    
    @IBAction func getDirections(_ sender: UIButton) {
        if favorite {
            guard let url = favoriteRecipe?.sourceUrl else {
                return
            }
            guard let link = URL(string: url) else {
                return
            }
            UIApplication.shared.open(link)
        } else {
            guard let url = recipe?.source.sourceRecipeUrl else {
                return
            }
            guard let link = URL(string: url) else {
                return
            }
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            guard let recipeID = favoriteRecipe?.id else {
                return
            }
            FavoriteRecipe.remove(recipeID)
        } else {
            sender.isSelected = true
            guard let recipe = recipe else {
                return
            }
            let listIngredient = ingredients.joined(separator: ", ")
            FavoriteRecipe.save(recipe, listIngredient)
        }
    }

    func searchRecipe(_ recipeID : String) {
        recipeService.getRecipe(recipeID) { (error, recipe) in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                self.showAlert(title: Constant.titleAlert, message: error)
                return
            }
            self.recipe = recipe
            self.displayRecipe()
            self.tableView.reloadData()
        }
    }

    func displayRecipe(){
        recipeView.recipe = recipe

        guard let ingredientLine = recipe?.ingredientLines else {
            return
        }
        self.preparation = ingredientLine
    }

    func displayFavorite() {
        recipeView.favoriteRecipe = favoriteRecipe

        guard let ingredients = favoriteRecipe?.ingredients?.allObjects as? [Ingredient] else {
            return
        }
        ingredients.forEach { element in
            guard let name = element.name else {
                return
            }
            preparation.append(name)
        }
    }
}

extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preparation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath)
        let nameIngredient = "-  \(self.preparation[indexPath.row])"
        cell.textLabel?.text = nameIngredient

        return cell
    }
}
