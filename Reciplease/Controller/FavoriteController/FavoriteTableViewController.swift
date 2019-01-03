//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 22/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    // MARK: - Properties
    var favoriteRecipe = FavoriteRecipe.all
    var displayAlertDelegate: DisplayAlert?
    // MARK: - Outlets
    @IBOutlet var recipeListTableView: UITableView!
    @IBOutlet weak var favoriteSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlertDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoriteRecipe = FavoriteRecipe.all
        recipeListTableView.reloadData()
    }
    // MARK: - Method
    func removeFavorite(_ cell: UITableViewCell) {
        guard let indexPath = recipeListTableView.indexPath(for: cell) else {
            return
        }
        guard let recipeID = favoriteRecipe[indexPath.row].id else {
            return
        }
        FavoriteRecipe.remove(recipeID)
        favoriteRecipe = FavoriteRecipe.all
        recipeListTableView.reloadData()
    }
}

// MARK: - TableView Management
extension FavoriteTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some favorite in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoriteRecipe.isEmpty ? 200 : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipe", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = favoriteRecipe[indexPath.row]
        cell.link = self
        cell.addFavoriteButton.tag = indexPath.row
        
        return cell
    }
}

// MARK: - SearchBar Management
extension FavoriteTableViewController:  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            favoriteRecipe = FavoriteRecipe.all
            recipeListTableView.reloadData()
        } else {
            favoriteRecipe = FavoriteRecipe.fetch(searchText)
            recipeListTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        favoriteRecipe = FavoriteRecipe.all
        recipeListTableView.reloadData()
    }
}

// MARK: - Navigation
extension FavoriteTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier) {
        case "favoriteRecipe":
            guard let recipeViewController = segue.destination as? RecipeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedRecipeCell = sender as? FavoriteTableViewCell else {
                fatalError("error envoi")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedRecipeCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            recipeViewController.favoriteRecipe = favoriteRecipe[indexPath.row]
            recipeViewController.recipeID = favoriteRecipe[indexPath.row].id
            
        default :
            print("error")
        }
    }
}
