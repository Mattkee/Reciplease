//
//  IngredientViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 24/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    // MARK: - Properties
    let ingredientService = IngredientService()
    var text : String {
        get {
            guard let searchText = searchTextField.text else {
                return ""
            }
            return searchText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonform.layer.cornerRadius = 20
        addButtonForm.layer.cornerRadius = 20
        clearButtonForm.layer.cornerRadius = 20
        ingredientTableView.dataSource = self
        ingredientTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var buttonform: UIButton!
    @IBOutlet weak var addButtonForm: UIButton!
    @IBOutlet weak var clearButtonForm: UIButton!
    // MARK: Methods
    func addText() {
        ingredientService.addText(self.text)
        ingredientTableView.reloadData()
        self.searchTextField.text?.removeAll()
    }
}

// MARK: - Actions
extension IngredientViewController {
    @IBAction func unwindToIngredient(segue:UIStoryboardSegue) {}
    @IBAction func addButton(_ sender: UIButton) {
        addText()
    }
    @IBAction func clearButton(_ sender: UIButton) {
        ingredientService.clear()
        ingredientTableView.reloadData()
    }
}

// MARK: - Table View dataSource Managements
extension IngredientViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ingredient", for: indexPath)
        
        let nameIngredient = "- \(Constant.ingredients[indexPath.row])"
        cell.textLabel?.text = nameIngredient
        
        return cell
    }
}
// MARK: - Table View dataSource Managements
extension IngredientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientService.removeIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Keyboard
extension IngredientViewController : UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addText()
        return true
    }
}
