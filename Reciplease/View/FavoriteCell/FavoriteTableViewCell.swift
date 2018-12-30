//
//  FavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 27/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

// MARK: - Favorite Cell
class FavoriteTableViewCell: UITableViewCell {
    // MARK: - Properties
    var link : FavoriteTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.blurView.layer.cornerRadius = 30
        self.blurView.layer.masksToBounds = true
        setupRating(ratingStackView, &ratingStar)
        addFavoriteButton.setImage(#imageLiteral(resourceName: "favorite") , for: .normal)
        // Initialization code
    }
    // MARK: - Outlets
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet var ratingStar: [UIImageView]!

    // MARK: - favoriteRecipe object allow to display cell data
    var favoriteRecipe : FavoriteRecipe! {
        didSet {
            self.recipeTitle.text = favoriteRecipe.name
            self.ingredientList.text = favoriteRecipe.ingredientsDetail
            
            self.timeLabel.text = favoriteRecipe.totalTime
            if let image = favoriteRecipe.image {
                self.recipeImage.image = UIImage.recipeImage(image)
            } else {
                self.recipeImage.image = UIImage(imageLiteralResourceName: "breakfast")
            }
            guard let rating = favoriteRecipe.rating else {
                return
            }
            ratingDisplay(rating, ratingStar)
        }
    }
}

// MARK: - Action
extension FavoriteTableViewCell {
    @IBAction func addRemoteFavorite(_ sender: UIButton) {
        link?.removeFavorite(self)
    }
}
