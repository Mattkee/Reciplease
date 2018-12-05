//
//  ParametersTableViewCell.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 29/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        backgroundColor = .red
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func headerSetupCell(image: UIImage, label: String) {
        headerImage.image = image
        headerLabel.text = label
    }
    func cellListSetup(_ label: String) {
        cellLabel.text = label
    }
}
