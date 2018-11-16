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
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let text = searchTextField.text else {
            return
        }
        Constant.ingredients.append(text)
        ingredientTableView.reloadData()
        self.searchTextField.text?.removeAll()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        clear()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
       
    }
    
    @IBOutlet weak var ingredientTableView: UITableView!
    
    func clear() {
        Constant.ingredients = [String]()
        ingredientTableView.reloadData()
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
