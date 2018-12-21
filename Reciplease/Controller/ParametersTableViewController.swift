//
//  ParametersViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 29/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let headerSectionImage : [UIImage] = [#imageLiteral(resourceName: "cookingChoice"),#imageLiteral(resourceName: "diets"),#imageLiteral(resourceName: "allergies")]
    
    var cookingChoice = [ListElement]()
    var diets = [ListElement]()
    var allergies = [ListElement]()

    var twoDimensionalArray = [Parameter]()

    @IBOutlet var parametersPopup: UITableView!
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBAction func saveButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parametersPopup.delegate = self
        parametersPopup.dataSource = self

        buttonSave.layer.cornerRadius = 10
        parametersPopup.layer.cornerRadius = 10
        parametersPopup.layer.masksToBounds = true
        
        addListElement(Constant.cookingChoice) { listElement in
            self.cookingChoice = listElement
        }
        addListElement(Constant.diets) { listElement in
            self.diets = listElement
        }
        addListElement(Constant.alergies) { listElement in
            self.allergies = listElement
        }
        twoDimensionalArray = [
            Parameter(isExpanded: false, title: "Cooking Choice", list: cookingChoice),
            Parameter(isExpanded: false, title: "Diets", list: diets),
            Parameter(isExpanded: false, title: "Allergies", list: allergies)
        ]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        // #warning Incomplete implementation, return the number of rows
//        let list = twoDimensionalArray[section].list
//        return list.count
        if twoDimensionalArray[section].isExpanded == true {
            return twoDimensionalArray[section].list.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell1") as! ParametersHeaderTableViewCell
        cell.headerSetupCell(image: headerSectionImage[section], label: twoDimensionalArray[section].title)

        cell.button.tag = section

        cell.button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parameters", for: indexPath) as! ParametersTableViewCell

        cell.cellListSetup(twoDimensionalArray[indexPath.section].list[indexPath.row].name)

        let checkmark = UITableViewCell.AccessoryType.checkmark
        if twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected == true {
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

    @IBAction func closePopUp(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
    
    @objc func handleExpandClose(_ button: UIButton) {
        let section = button.tag

        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        parametersPopup.reloadData()
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
