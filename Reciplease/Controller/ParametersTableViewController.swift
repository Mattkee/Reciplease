//
//  ParametersViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 29/11/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let headerSectionImage : [UIImage] = [#imageLiteral(resourceName: "breakfast"),#imageLiteral(resourceName: "breakfast"),#imageLiteral(resourceName: "breakfast")]
    
    var cookingChoice = [ListElement]()
    var diets = [ListElement]()
    var allergies = [ListElement]()

    var twoDimensionalArray = [Parameter]()
//    let headerSectionLabel : [String] = ["Cooking Choice", "Diets", "Allergies"]
//    let cuisineList = ["American", "Italian", "Asian", "Mexican", "Southern & Soul Food", "French", "Southwestern", "Barbecue", "Indian", "Chinese", "Cajun & Creole", "English", "Mediterranean", "Greek", "Spanish", "German", "Thai", "Moroccan", "Irish", "Japanese", "Cuban", "Hawaiin", "Swedish", "Hungarian", "Portugese"]
//    let diet = ["Lacto vegetarian", "Ovo vegetarian", "Pescetarian", "Vegan", "Vegetarian"]
//    let allergies = ["Dairy", "Egg", "Gluten", "Peanut", "Seafood", "Sesame", "Soy", "Sulfite", "Tree Nut", "Wheat"]
//    var sectionData : [Int: [String]] = [:]

    @IBOutlet var parametersPopup: UITableView!
    
    @IBAction func saveButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parametersPopup.delegate = self
        parametersPopup.dataSource = self
        
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
            Parameter(isExpanded: true, title: "Cooking Choice", list: cookingChoice),
            Parameter(isExpanded: true, title: "Diets", list: diets),
            Parameter(isExpanded: true, title: "Allergies", list: allergies)
        ]
//        sectionData = [0: cuisineList, 1: diet, 2: allergies]
//        parametersPopup.register(ParametersTableViewCell.self, forCellReuseIdentifier: "parameters")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return twoDimensionalArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let list = twoDimensionalArray[section].list
        return list.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell1") as! ParametersTableViewCell
        cell.headerSetupCell(image: headerSectionImage[section], label: twoDimensionalArray[section].title)
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parameters", for: indexPath) as! ParametersTableViewCell

        cell.cellListSetup(twoDimensionalArray[indexPath.section].list[indexPath.row].name)

        let checkmark = UITableViewCell.AccessoryType.checkmark
        if twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected == true {
            cell.accessoryType = checkmark
            cell.isSelected = true
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected == false {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = true
        } else {
            twoDimensionalArray[indexPath.section].list[indexPath.row].isSelected = false
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
//    func addParameters(_ section: Int, _ value: Int) {
//        if section == 0 {
//            Constant.cuisineList.append(cuisineList[value])
//            print(cuisineList[value])
//        }
//    }
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
