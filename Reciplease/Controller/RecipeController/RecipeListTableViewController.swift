//
//  RecipeListTableViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 13/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    // MARK: - Properties
    let recipeService = RecipeService()
    var searchResult : SearchRecipe?
    var activityIndicator = false
    var displayAlertDelegate: DisplayAlert?
    // MARK: - Outlets
    @IBOutlet var recipeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = true
        displayAlertDelegate = self
        searchRecipe()
    }
    override func viewWillAppear(_ animated: Bool) {
        recipeListTableView.reloadData()
    }
}

// MARK: - Methods
extension RecipeListTableViewController {
    private func searchRecipe() {
        recipeService.getSearchRecipe { (error, recipes) in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                self.showAlert(title: Constant.titleAlert, message: error)
                return
            }
            self.searchResult = recipes
            self.activityIndicator = false
            self.recipeListTableView.reloadData()
        }
    }
    // MARK : - CoreData add remove Data
    func addRemoveFavorite(_ cell: UITableViewCell) {
        guard let indexPath = recipeListTableView.indexPath(for: cell) else {
            return
        }
        guard let searchRecipe = searchResult?.matches[indexPath.row] else {
            return
        }
        if FavoriteRecipe.all.contains(where: {$0.id == searchRecipe.id}) {
            FavoriteRecipe.remove(searchRecipe.id)
            recipeListTableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            saveRecipeToFavorite(indexPath, searchRecipe)
            
        }
    }
    // Mark: - Network call
    private func saveRecipeToFavorite(_ indexPath: IndexPath, _ searchRecipe: SearchRecipe.Matches) {
        recipeService.getRecipe(searchRecipe.id) { (error, recipe) in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                self.showAlert(title: Constant.titleAlert, message: error)
                return
            }
            let listIngredient = searchRecipe.ingredients.joined(separator: ", ")
            guard let resultRecipe = recipe else {
                return
            }
            FavoriteRecipe.save(resultRecipe, listIngredient)
            self.recipeListTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Table view data source
extension RecipeListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = searchResult?.matches else {
            return 0
        }
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        cell.searchRecipe = searchResult?.matches[indexPath.row]
        
        var isFavorite : Bool {
            if let recipe = searchResult?.matches[indexPath.row] {
                let favorite = FavoriteRecipe.all.contains(where: { $0.id == recipe.id })
                return favorite
            } else {
                return false
            }
        }
        cell.link = self
        cell.favorite(isFavorite)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") as? FooterTableViewCell else {
            return UITableViewCell()
        }
        cell.activityIndicator.startAnimating()
        cell.label.text = "please wait, we are looking for recipes..."
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return activityIndicator ? 200 : 0
    }
}

// MARK: - Navigation
extension RecipeListTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier) {
        case "recipe":
            guard let recipeViewController = segue.destination as? RecipeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedRecipeCell = sender as? SearchResultTableViewCell else {
                fatalError("error envoi")
            }
            guard let indexPath = tableView.indexPath(for: selectedRecipeCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            guard let id = searchResult?.matches[indexPath.row].id else {
                fatalError("no id")
            }
            guard let ingredients = searchResult?.matches[indexPath.row].ingredients else {
                fatalError("no ingredients")
            }
            recipeViewController.recipeID = id
            recipeViewController.ingredients = ingredients
        default :
            print("error")
        }
    }
}
