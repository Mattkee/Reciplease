//
//  MainTabBarController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 22/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTabBar.isHidden = true
        
        
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.white.cgColor
        favoriteButton.layer.borderWidth = 1
        favoriteButton.layer.borderColor = UIColor.white.cgColor
        self.newBar.translatesAutoresizingMaskIntoConstraints =  false
        self.view.addSubview(newBar)
//        self.newBar.heightAnchor.constraint(equalTo: self.mainTabBar.heightAnchor, constant: 50)
        self.newBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40).isActive = true
        self.newBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.newBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
//        self.newBar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var newBar: UIView!
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    @IBAction func changeTab(sender: UIButton) {
        self.selectedIndex = sender.tag
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
