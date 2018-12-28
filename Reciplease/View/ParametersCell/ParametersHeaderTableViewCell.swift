//
//  ParametersHeaderTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 17/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func headerSetupCell(image: UIImage, label: String) {
        headerImage.image = image
        headerLabel.text = label
    }
}
