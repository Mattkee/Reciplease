//
//  SearchResultTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 24/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//
import UIKit

// MARK: - SearchResult Cell
class SearchResultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var link : RecipeListTableViewController?
    var isFavorite = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        setupRating(ratingStackView, &ratingStar)
        // Initialization code
    }

    // MARK: - Outlets
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var favoriteActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var ratingStar: [UIImageView]!

    // MARK: - SearchRecipe object allow to display cell data
    var searchRecipe : SearchRecipe.Matches! {
        didSet {
            self.recipeTitle.text = searchRecipe.recipeName
            let ingredients = searchRecipe.ingredients.joined(separator: ", ")
            self.ingredientList.text = ingredients
            
            let time = timeFormatted(totalSeconds: searchRecipe.totalTimeInSeconds)
            self.timeLabel.text = time
            let image = UIImage.recipeImage(searchRecipe.smallImageUrls[0])
            self.recipeImage.image = image
            ratingDisplay(String(searchRecipe.rating), ratingStar)
        }
    }
}

// MARK: - Action
extension SearchResultTableViewCell {
    @IBAction func addRemoteFavorite(_ sender: UIButton) {
        favoriteActivityIndicator.color = .black
        favoriteActivityIndicator.isHidden = false
        favoriteActivityIndicator.startAnimating()
        addFavoriteButton.isHidden = true
        link?.addRemoveFavorite(self)
    }
}

// MARK: Method
extension SearchResultTableViewCell {
    func favorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        addFavoriteButton.setImage(isFavorite ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "add-favorite"), for: .normal)
        favoriteActivityIndicator.stopAnimating()
        favoriteActivityIndicator.isHidden = true
        addFavoriteButton.isHidden = false
    }
}
