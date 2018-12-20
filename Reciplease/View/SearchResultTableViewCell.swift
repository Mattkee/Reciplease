//
//  SearchResultTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 24/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//
import UIKit

class SearchResultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var searchRecipe : SearchRecipe.Matches! {
        didSet {
            self.recipeTitle.text = searchRecipe.recipeName
            let ingredients = searchRecipe.ingredients.joined(separator: ", ")
            self.ingredientList.text = ingredients
            self.ratingLabel.text = String(searchRecipe.rating)
            let time = timeFormatted(totalSeconds: searchRecipe.totalTimeInSeconds)
            self.timeLabel.text = time
            let image = UIImage.recipeImage(searchRecipe.smallImageUrls[0])
            self.recipeImage.image = image
        }
    }
//    var recipe : Recipe! {
//        didSet {
//            self.recipeTitle.text = recipe.name
//            let ingredients = recipe.ingredientLines.joined(separator: ", ")
//            self.ingredientList.text = ingredients
//            self.ratingLabel.text = String(recipe.rating)
//            self.timeLabel.text = recipe.totalTime
//            let image = UIImage.recipeImage(recipe.images[0].hostedSmallUrl)
//            self.recipeImage.image = image
//        }
//    }

    var favoriteRecipe : FavoriteRecipe! {
        didSet {
            self.recipeTitle.text = favoriteRecipe.name
            let ingredientList = favoriteRecipe.ingredients?.allObjects as? [String] ?? [String]()
            let ingredients = ingredientList.joined(separator: ", ")
            self.ingredientList.text = ingredients
            self.ratingLabel.text = favoriteRecipe.rating
            self.timeLabel.text = favoriteRecipe.totalTime
            if let image = favoriteRecipe.image {
                self.recipeImage.image = UIImage.recipeImage(image)
            } else {
                self.recipeImage.image = UIImage(imageLiteralResourceName: "breakfast")
            }
        }
    }

    private  func timeFormatted(totalSeconds: Int) -> String {
        //        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = totalSeconds / 3600
        if hours == 0 {
            return String(format: "%02dmin", minutes)
        } else {
            return String(format: "%01dh %02dmin", hours, minutes)
        }
    }
}
