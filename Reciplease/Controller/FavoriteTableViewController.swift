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
    var displayAlertDelegate: DisplayAlert?
    
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRecipe", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = favoriteRecipe[indexPath.row]
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
