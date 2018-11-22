//
//  UIImage + Extension.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 19/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func recipeImage(_ url: String) -> UIImage {
        let finalUrl = String(url.dropLast(2) + "300")
        
        guard let imageUrl = URL(string: finalUrl) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        
        guard let image = UIImage(data: imageData) else {
            return UIImage(imageLiteralResourceName: "breakfast")
        }
        return image
    }
}

