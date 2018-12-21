//
//  UIViewControler + Extension.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 22/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController : DisplayAlert {
    func showAlert(title: String, message: String) {
        let alerteVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
    func ratingDisplay(_ rating: String, _ collectionImage: [UIImageView]) {
        switch rating {
        case "1":
            collectionImageView(collectionImage, true, false, false, false, false)
        case "2":
            collectionImageView(collectionImage, true, true, false, false, false)
        case "3":
            collectionImageView(collectionImage, true, true, true, false, false)
        case "4":
            collectionImageView(collectionImage, true, true, true, true, false)
        case "5":
            collectionImageView(collectionImage, true, true, true, true, true)
        default:
            print("aucune image")
        }
    }
    func collectionImageView(_ collectionImage: [UIImageView],_ oneStar: Bool,_ twoStar: Bool,_ threeStar: Bool,_ fourStar: Bool,_ fiveStar: Bool) {
        collectionImage[0].image = oneStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "star-white-small")
        collectionImage[1].image = twoStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "star-white-small")
        collectionImage[2].image = threeStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "star-white-small")
        collectionImage[3].image = fourStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "star-white-small")
        collectionImage[4].image = fiveStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "star-white-small")
    }
}
