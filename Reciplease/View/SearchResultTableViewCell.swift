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
    
    func configure(recipeTitle: String, ingredientList: String, ratingLabel: String, timeLabel: String, recipeImage: UIImage) {
        self.recipeTitle.text = recipeTitle
        self.ingredientList.text = ingredientList
        self.ratingLabel.text = ratingLabel
        self.timeLabel.text = timeLabel
        self.recipeImage.image = recipeImage
    }
}
