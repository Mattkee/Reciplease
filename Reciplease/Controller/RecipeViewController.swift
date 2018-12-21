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
        getDirectionsButton.layer.cornerRadius = 10
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
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet var ratingImage: [UIImageView]!
    
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
    
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
        if sender.image == #imageLiteral(resourceName: "star-yellow-small") {
            sender.image = #imageLiteral(resourceName: "star-white-small")
            guard let recipeID = favoriteRecipe?.id else {
                return
            }
            FavoriteRecipe.remove(recipeID)
        } else {
            sender.image = #imageLiteral(resourceName: "star-yellow-small")
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
        guard let name = recipe?.name else {
            return
        }
        self.recipeName.text = name
        guard let rating = recipe?.rating else {
            return
        }
        ratingDisplay(String(rating), ratingImage)
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
        ratingDisplay(String(rating), ratingImage)
        guard let time = favoriteRecipe?.totalTime else {
            print("3")
            return
        }
        self.recipeTime.text = time
        guard let ingredients = favoriteRecipe?.ingredients?.allObjects as? [Ingredient] else {
            return
        }
        ingredients.forEach { element in
            guard let name = element.name else {
                return
            }
            preparation.append(name)
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
