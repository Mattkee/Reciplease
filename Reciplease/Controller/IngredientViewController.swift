//
//  IngredientViewController.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 24/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.dataSource = self
        ingredientTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recipeViewParameters: UIView!
    
    @IBAction func addButton(_ sender: UIButton) {
        addText()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        clear()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
       
    }
    
    @IBAction func recipeParameters(_ sender: UIBarButtonItem) {
        if recipeViewParameters.isHidden == true {
            recipeViewParameters.isHidden = false
        } else {
            recipeViewParameters.isHidden = true
        }
    }

    @IBOutlet weak var ingredientTableView: UITableView!
    
    func clear() {
        Constant.ingredients = [String]()
        ingredientTableView.reloadData()
    }
    
    func ingredienttext(_ text: String) -> [String] {
        var list = text.components(separatedBy: ", ")
        list.forEach { element in
            if element.contains(",") {
                let test = element.components(separatedBy: ",")
                list.append(contentsOf: test)
                list.removeAll(where: {$0 == element})
            }
        }
        return list
    }
    func addText() {
        guard let text = searchTextField.text else {
            return
        }
        if text.contains(",") {
            let finalTest = ingredienttext(text)
            Constant.ingredients.append(contentsOf: finalTest)
        } else {
            Constant.ingredients.append(text)
        }
        ingredientTableView.reloadData()
        self.searchTextField.text?.removeAll()
    }
    func removeIngredient(at index: Int) {
        Constant.ingredients.remove(at: index)
    }
}

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

extension IngredientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeIngredient(at: indexPath.row)
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
