//
//  ParametersHeaderTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 17/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersHeaderTableViewCell: UITableViewCell {

//    var link : ParametersViewController?

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle("close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        accessoryView = button
        // Initialization code
//        backgroundColor = .yellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//
    var button = UIButton(type: .system)
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func headerSetupCell(image: UIImage, label: String) {
        headerImage.image = image
        headerLabel.text = label
    }
}