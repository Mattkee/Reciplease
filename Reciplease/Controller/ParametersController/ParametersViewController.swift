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
    var cookingChoice = [ListElement]()
    var diets = [ListElement]()
    var allergies = [ListElement]()
    var twoDimensionalArray = [Parameter]()
    // MARK: - Outlets
    @IBOutlet var parametersPopup: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        parametersPopup.delegate = self
        parametersPopup.dataSource = self

        parametersPopup.layer.cornerRadius = 20
        parametersPopup.layer.masksToBounds = true
        
        updateParametersList()
        
        twoDimensionalArray = [
            Parameter(isExpanded: false, title: "Cooking Choice", list: cookingChoice),
            Parameter(isExpanded: false, title: "Diets", list: diets),
            Parameter(isExpanded: false, title: "Allergies", list: allergies)
        ]
    }
}
// MARK: - Methods
extension ParametersViewController {
    func updateParametersList() {
        addListElement(Constant.cookingChoice) { listElement in
            self.cookingChoice = listElement
        }
        addListElement(Constant.diets) { listElement in
            self.diets = listElement
        }
        addListElement(Constant.alergies) { listElement in
            self.allergies = listElement
        }
    }

    func addListElement(_ list: [String], callback: @escaping ([ListElement]) -> Void) {
        var listElement = [ListElement]()
        list.forEach { element in
            listElement.append(ListElement(name: element, isSelected: false))
        }
        callback(listElement)
    }

    func addParameters(_ section: Int, _ element: String) {
        if section == 0 {
            Constant.cookingParameters.append(element)
        } else if section == 1 {
            Constant.dietsParameters.append(element)
        } else {
            Constant.alergiesParameters.append(element)
        }
    }
    
    func removeParameters(_ section: Int, _ element: String) {
        if section == 0 {
            guard let index = Constant.cookingParameters.firstIndex(of: element) else {
                return
            }
            Constant.cookingParameters.remove(at: index)
        } else if section == 1 {
            guard let index = Constant.dietsParameters.firstIndex(of: element) else {
                return
            }
            Constant.dietsParameters.remove(at: index)
        } else {
            guard let index = Constant.alergiesParameters.firstIndex(of: element) else {
                return
            }
            Constant.alergiesParameters.remove(at: index)
        }
    }

    func searchParametersInConstant(_ name: String) -> Bool {
        var isParameter = false
        if Constant.alergiesParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        if Constant.dietsParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        if Constant.cookingParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        return isParameter
    }

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
        let isParameter = searchParametersInConstant(twoDimensionalArray[indexPath.section].list[indexPath.row].name)
        if isParameter {
            cell.accessoryType = checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected == false {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = true
            addParameters(indexPath.section, twoDimensionalArray[indexPath.section].list[indexPath.row].name)
            tableView.reloadData()
        } else {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = false
            removeParameters(indexPath.section, twoDimensionalArray[indexPath.section].list[indexPath.row].name)
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
