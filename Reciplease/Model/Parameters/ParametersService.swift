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
    var cookingChoice = [ListElement]()
    var diets = [ListElement]()
    var allergies = [ListElement]()
    var twoDimensionalArray = [Parameter]()

    // MARK: - Methods
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
        twoDimensionalArray = [
            Parameter(isExpanded: false, title: "Cooking Choice", list: cookingChoice),
            Parameter(isExpanded: false, title: "Diets", list: diets),
            Parameter(isExpanded: false, title: "Allergies", list: allergies)
        ]
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
