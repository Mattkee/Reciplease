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
    var recipe: Recipe?
    var recipeWithImage = [RecipeWithImage]()
    var myIndex = 0

    var displayAlertDelegate: DisplayAlert?

    @IBOutlet var recipeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlertDelegate = self
        searchRecipe()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func searchRecipe() {
        recipeService.getRecipe { (error, recipe) in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                self.showAlert(title: Constant.titleAlert, message: error)
                return
            }
            self.recipe = recipe
            self.recipeListTableView.reloadData()
        }
    }
    
    private func recipeImage(_ url: String) -> UIImage {
        let finalUrl = String(url.dropLast(2) + "300")
        
        guard let imageUrl = URL(string: finalUrl) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        
        guard let image = UIImage(data: imageData) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        return image
    }

    func timeFormatted(totalSeconds: Int) -> String {
//        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = totalSeconds / 3600
        if hours == 0 {
            return String(format: "%02dmin", minutes)
        } else {
            return String(format: "%01dh %02dmin", hours, minutes)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let recipeList = recipe?.matches else {
            return 0
        }
        return recipeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        guard let recipeTitle = recipe?.matches[indexPath.row].recipeName else {
            return UITableViewCell()
        }
        guard let ingredientList = recipe?.matches[indexPath.row].ingredients else {
            return UITableViewCell()
        }
        let ingredients = ingredientList.joined(separator: ", ")
        guard let ratingLabel = recipe?.matches[indexPath.row].rating else {
            return UITableViewCell()
        }
        let rating = String(ratingLabel)
        guard let timeLabel = recipe?.matches[indexPath.row].totalTimeInSeconds else {
            return UITableViewCell()
        }
        let time = timeFormatted(totalSeconds: timeLabel)
//        let time = String(timeLabel)
        guard let url = recipe?.matches[indexPath.row].smallImageUrls[0] else {
            return UITableViewCell()
        }
        let image = recipeImage(url)

        recipeWithImage.append(RecipeWithImage(recipeName: recipeTitle, recipeIngredients: ingredientList, recipeImage: image, recipeTime: time, recipeRating: rating))
        cell.configure(recipeTitle: recipeTitle, ingredientList: ingredients, ratingLabel: rating, timeLabel: time, recipeImage: image)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
//        performSegue(withIdentifier: "recipe", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
                recipeViewController.recipeWithImage = self.recipeWithImage[indexPath.row]
            default :
                print("error")
        }
    }

}

// MARK: - Alert Management
extension RecipeListTableViewController: DisplayAlert {
    func showAlert(title: String, message: String) {
        let alerteVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
}

