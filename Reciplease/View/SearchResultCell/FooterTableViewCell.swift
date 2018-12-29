//
//  FooterTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 27/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

// MARK: - SearchResult Cell footer
class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.color = #colorLiteral(red: 0.1704318452, green: 0.5921696838, blue: 0.7852094769, alpha: 1)
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
    }
}
