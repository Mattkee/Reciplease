//
//  ParametersHeaderTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 17/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

// MARK: - Parameters Cell header
class ParametersHeaderTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
    }

    // MARK: - Method
    func headerSetupCell(image: UIImage, label: String) {
        headerImage.image = image
        headerLabel.text = label
    }
}
