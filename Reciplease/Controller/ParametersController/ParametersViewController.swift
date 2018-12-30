//
//  ParametersViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 29/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController {
    // MARK: - Properties
    let headerSectionImage : [UIImage] = [#imageLiteral(resourceName: "cookingChoice"),#imageLiteral(resourceName: "diets"),#imageLiteral(resourceName: "allergies")]
    var twoDimensionalArray = [Parameter]()
    let parametersService = ParametersService()
    
    // MARK: - Outlets
    @IBOutlet var parametersPopup: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        parametersPopup.delegate = self
        parametersPopup.dataSource = self

        parametersService.updateParametersList()
        twoDimensionalArray = parametersService.twoDimensionalArray
    }
    // MARK: - Method
    @objc func handleExpandClose(_ button: UIButton) {
        let section = button.tag
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        parametersPopup.reloadData()
    }
}

// MARK: - TableView management DataSource
extension ParametersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if twoDimensionalArray[indexPath.section].isExpanded == true {
            return 45
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if twoDimensionalArray[section].isExpanded == true {
            return twoDimensionalArray[section].list.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parameters", for: indexPath) as! ParametersTableViewCell
        
        cell.cellListSetup(twoDimensionalArray[indexPath.section].list[indexPath.row].name)
        
        let checkmark = UITableViewCell.AccessoryType.checkmark
        let isParameter = parametersService.searchParametersInConstant(twoDimensionalArray[indexPath.section].list[indexPath.row].name)

        if isParameter {
            cell.accessoryType = checkmark
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = true
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = twoDimensionalArray[indexPath.section].list[indexPath.row]
        if selected.isSelected == false {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = true
            parametersService.addParameters(indexPath.section, selected.name)
            tableView.reloadData()
        } else {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = false
            parametersService.removeParameters(indexPath.section, selected.name)
            tableView.reloadData()
        }
    }
}

// MARK: - TableView management DataSource headerCell
extension ParametersViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell1") as! ParametersHeaderTableViewCell
        cell.headerSetupCell(image: headerSectionImage[section], label: twoDimensionalArray[section].title)
        
        cell.addButton.tag = section
        let isExpanded = twoDimensionalArray[section].isExpanded
        cell.addButton.setImage(isExpanded ? #imageLiteral(resourceName: "close-image") : #imageLiteral(resourceName: "add-image") ,for: .normal)
        
        cell.addButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return cell
    }
}
