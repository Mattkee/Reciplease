//
//  ParametersTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 29/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

// MARK: - Parameters Cell
class ParametersTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Method
    func cellListSetup(_ label: String) {
        cellLabel.text = label
    }
}
