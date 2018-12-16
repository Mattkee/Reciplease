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
    var favorite : Bool {
        if recipeID != nil {
            let favorite = FavoriteRecipe.all.contains(where: { $0.id == recipeID })
            return favorite
        } else if favoriteRecipe != nil {
            let favorite = FavoriteRecipe.all.contains(where: { $0.id == favoriteRecipe?.id })
            recipeID = favoriteRecipe?.id
            return favorite
        } else {
            return false
        }
    }

    var preparation = [String]()

    var displayAlertDelegate: DisplayAlert?

    override func viewDidLoad() {
        super.viewDidLoad()
        if favorite {
            favoriteButton.image = UIImage(imageLiteralResourceName: "star-yellow-small")
            let favorite = FavoriteRecipe.all.first(where: { $0.id == recipeID })
            self.favoriteRecipe = favorite
            displayFavorite()
        } else {
            guard let id = recipeID else {
                return
            }
            searchRecipe(id)
        }
        
        // Do any additional setup after loading the view
    }

    override func viewWillAppear(_ animated: Bool) {
        if favorite {
            favoriteButton.image = UIImage(imageLiteralResourceName: "star-yellow-small")
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
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(imageLiteralResourceName: "star-yellow-small") {
            sender.image = UIImage(imageLiteralResourceName: "star-white-small")
            guard let recipeID = favoriteRecipe?.id else {
                print("ça marche pas")
                return
            }
            print("ça marche")
            FavoriteRecipe.remove(recipeID)
//            Constant.favorites.removeAll(where: { $0.name == recipeName })
//            Constant.favorites.forEach { recipe in
//                print(recipe.name)
//            }
        } else {
            sender.image = UIImage(imageLiteralResourceName: "star-yellow-small")
            guard let recipe = recipe else {
                return
            }
            FavoriteRecipe.save(recipe.name, recipe.id, recipe.totalTime, String(recipe.rating), recipe.ingredientLines, recipe.images[0].hostedSmallUrl)
//            Constant.favorites.append(recipe)
//            Constant.favorites.forEach { recipe in
//                print(recipe.name)
//            }
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
        guard let name = recipe?.name else {
            return
        }
        self.recipeName.text = name
        guard let rating = recipe?.rating else {
            return
        }
        self.recipeRating.text = String(rating)
        guard let time = recipe?.totalTime else {
            return
        }
        self.recipeTime.text = time
        guard let ingredientLine = recipe?.ingredientLines else {
            return
        }
        self.preparation = ingredientLine
        guard let image = recipe?.images[0].hostedSmallUrl else {
            return
        }
        self.recipeImage.image = UIImage.recipeImage(image)
    }
    func displayFavorite() {
        guard let name = favoriteRecipe?.name else {
            print("1")
            return
        }
        self.recipeName.text = name
        guard let rating = favoriteRecipe?.rating else {
            print("2")
            return
        }
        self.recipeRating.text = rating
        guard let time = favoriteRecipe?.totalTime else {
            print("3")
            return
        }
        self.recipeTime.text = time
        let ingredients = Ingredient.all
        ingredients.forEach { element in
            if element.recipe == favoriteRecipe {
                if let name = element.name {
                    preparation.append(name)
                }
            }
        }
        guard let image = favoriteRecipe?.image else {
            print("4")
            return
        }
        self.recipeImage.image = UIImage.recipeImage(image)
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
