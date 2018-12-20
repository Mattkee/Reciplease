//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 22/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var favoriteRecipe = FavoriteRecipe.all
    var searchFavorite = [FavoriteRecipe]()
    var searching = false

    var displayAlertDelegate: DisplayAlert?
    
    @IBOutlet var recipeListTableView: UITableView!

    @IBOutlet weak var favoriteSearchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlertDelegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchFavorite = [FavoriteRecipe]()
        self.favoriteRecipe = FavoriteRecipe.all
        recipeListTableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searching {
            return searchFavorite.count
        } else {
            return favoriteRecipe.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipe", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        if searching {
            cell.favoriteRecipe = searchFavorite[indexPath.row]
        } else {
            cell.favoriteRecipe = favoriteRecipe[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier) {
        case "favoriteRecipe":
            guard let recipeViewController = segue.destination as? RecipeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedRecipeCell = sender as? SearchResultTableViewCell else {
                fatalError("error envoi")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedRecipeCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            recipeViewController.favoriteRecipe = favoriteRecipe[indexPath.row]
            
        default :
            print("error")
        }
    }
}

extension FavoriteTableViewController:  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFavorite = favoriteRecipe.filter({$0.name!.prefix(searchText.count) == searchText})
        searching = true
        recipeListTableView.reloadData()
    }
}