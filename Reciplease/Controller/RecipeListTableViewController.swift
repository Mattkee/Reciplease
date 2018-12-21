//
//  RecipeListTableViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 13/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {

    let recipeService = RecipeService()
    var searchResult : SearchRecipe?

    var displayAlertDelegate: DisplayAlert?

    @IBOutlet var recipeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlertDelegate = self
        searchRecipe()
    }

    override func viewWillAppear(_ animated: Bool) {
        recipeListTableView.reloadData()
    }

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
            self.recipeListTableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        return cell
    }
   
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
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

