//
//  ParametersService.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 30/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation

class ParametersService {
    // MARK: - Properties
    private var cookingChoice = [ListElement]()
    private var diets = [ListElement]()
    private var allergies = [ListElement]()
    var twoDimensionalArray = [Parameter]()

    // MARK: - Methods
    func updateParametersList() {
        let cuisineObject = recoverBundleParameters("Cuisine")
        let dietObject = recoverBundleParameters("Diet")
        let allergyObject = recoverBundleParameters("Allergy")
        
        addListElement(cuisineObject) { listElement in
            self.cookingChoice = listElement
        }
        addListElement(dietObject) { listElement in
            self.diets = listElement
        }
        addListElement(allergyObject) { listElement in
            self.allergies = listElement
        }
        twoDimensionalArray = [
            Parameter(isExpanded: false, title: "Cooking Choice", list: cookingChoice),
            Parameter(isExpanded: false, title: "Diets", list: diets),
            Parameter(isExpanded: false, title: "Allergies", list: allergies)
        ]
    }

    private func recoverBundleParameters(_ nameBundle: String) -> [YummlyParameters] {
        let bundle = Bundle(for: ParametersService.self)
        let url = bundle.url(forResource: nameBundle, withExtension: "json")!
        guard let object = try? JSONDecoder().decode([YummlyParameters].self, from: Data(contentsOf: url)) else {
            return [YummlyParameters]()
        }
        return object
    }

    private func addListElement(_ list: [YummlyParameters], callback: @escaping ([ListElement]) -> Void) {
        var listElement = [ListElement]()
        list.forEach { element in
            listElement.append(ListElement(element: element, isSelected: false))
        }
        callback(listElement)
    }
    
    func addParameters(_ section: Int, _ element: String) {
        if section == 0 {
            ParametersRecording.cookingParameters.append(element)
        } else if section == 1 {
            ParametersRecording.dietsParameters.append(element)
        } else {
            ParametersRecording.alergiesParameters.append(element)
        }
        
    }
    
    func removeParameters(_ section: Int, _ element: String) {
        if section == 0 {
            guard let index = ParametersRecording.cookingParameters.firstIndex(of: element) else {
                return
            }
            ParametersRecording.cookingParameters.remove(at: index)
        } else if section == 1 {
            guard let index = ParametersRecording.dietsParameters.firstIndex(of: element) else {
                return
            }
            ParametersRecording.dietsParameters.remove(at: index)
        } else {
            guard let index = ParametersRecording.alergiesParameters.firstIndex(of: element) else {
                return
            }
            ParametersRecording.alergiesParameters.remove(at: index)
        }
    }
    
    func searchParametersInConstant(_ name: String) -> Bool {
        var isParameter = false
        if ParametersRecording.alergiesParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        if ParametersRecording.dietsParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        if ParametersRecording.cookingParameters.contains(where: {$0 == name}) {
            isParameter = true
        }
        return isParameter
    }

    func clearParameters() {
        ParametersRecording.cookingParameters.removeAll()
        ParametersRecording.dietsParameters.removeAll()
        ParametersRecording.alergiesParameters.removeAll()
    }
}
