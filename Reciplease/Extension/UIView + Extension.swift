//
//  UIView + Extension.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 28/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // MARK: - format Time
    func timeFormatted(totalSeconds: Int) -> String {
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = totalSeconds / 3600
        if hours == 0 {
            return String(format: "%02dmin", minutes)
        } else {
            return String(format: "%01dh %02dmin", hours, minutes)
        }
    }
    // MARK: - add five star
    func setupRating(_ stackView: UIStackView,_ collectionImageView: inout [UIImageView]) {
        for _ in 0..<5 {
            let imageView = UIImageView()
            stackView.addArrangedSubview(imageView)
            
            collectionImageView.append(imageView)
        }
    }
    // MARK: - display star rating
    func ratingDisplay(_ rating: String, _ collectionImage: [UIImageView]) {
        switch rating {
        case "0":
            collectionImageView(collectionImage, false, false, false, false, false)
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
            print("no image")
        }
    }
    func collectionImageView(_ collectionImage: [UIImageView],_ oneStar: Bool,_ twoStar: Bool,_ threeStar: Bool,_ fourStar: Bool,_ fiveStar: Bool) {
        collectionImage[0].image = oneStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "black-small-star")
        collectionImage[1].image = twoStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "black-small-star")
        collectionImage[2].image = threeStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "black-small-star")
        collectionImage[3].image = fourStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "black-small-star")
        collectionImage[4].image = fiveStar ? #imageLiteral(resourceName: "star-yellow-small") : #imageLiteral(resourceName: "black-small-star")
    }
}
