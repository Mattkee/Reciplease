//
//  FavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 27/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    var link : FavoriteTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        setupRating()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    
    @IBOutlet var ratingStar: [UIImageView]!
    
    @IBAction func addRemoteFavorite(_ sender: UIButton) {
        link?.removeFavorite(self)
    }
    
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
    private func setupRating() {
        for _ in 0..<5 {
            let imageView = UIImageView()
            ratingStackView.addArrangedSubview(imageView)
            
            ratingStar.append(imageView)
        }
    }
}
