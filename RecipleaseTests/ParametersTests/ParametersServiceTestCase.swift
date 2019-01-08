//
//  ParametersServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 08/01/2019.
//  Copyright © 2019 Mattkee. All rights reserved.
//

import XCTest
@testable import Reciplease

class ParametersServiceTestCase: XCTestCase {

    var parametersService : ParametersService!

    override func setUp() {
        super.setUp()
        parametersService = ParametersService()
        parametersService.clearParameters()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        parametersService.clearParameters()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    private func recoverBundleParameters(_ nameBundle: String) -> [YummlyParameters] {
        let bundle = Bundle(for: ParametersService.self)
        let url = bundle.url(forResource: nameBundle, withExtension: "json")!
        guard let object = try? JSONDecoder().decode([YummlyParameters].self, from: Data(contentsOf: url)) else {
            return [YummlyParameters]()
        }
        return object
    }
    
    func testGivenTwoDimensionalArrayIsEmpty_WhenUpdateParametersList_ThenTwoDimensionalArrayIsNotEmptyAndDataIsCorrect() {
        //Given
        parametersService.twoDimensionalArray = [Parameter]()
        //When
        parametersService.updateParametersList()
        //Then
        let object = recoverBundleParameters("Cuisine")
        let parameters = parametersService.twoDimensionalArray[0].list
        XCTAssertFalse(parametersService.twoDimensionalArray.isEmpty)
        XCTAssertEqual(object[0].name, parameters[0].element.name)
    }

    func testGivenNoParametersSaveInUserDefault_WhenAddingParameters_ThenParametersIsNotEmptyInUserDefaultStorageAndDataIsCorrect() {
        //Given
        let cookingChoice = "cuisine^cuisine-american"
        let dietChoice = "Ketogenic"
        let allergyChoice = "Gluten-Free"
        //When
        parametersService.addParameters(0, cookingChoice)
        parametersService.addParameters(1, dietChoice)
        parametersService.addParameters(2, allergyChoice)
        //Then
        XCTAssertEqual(ParametersRecording.cookingParameters[0], cookingChoice)
        XCTAssertEqual(ParametersRecording.dietsParameters[0], dietChoice)
        XCTAssertEqual(ParametersRecording.alergiesParameters[0], allergyChoice)
    }
    func testGivenThreeParametersSaveInUserDefault_WhenRemovingOneByOneParameters_ThenParametersIsEmptyInUserDefaultStorageAndDataIsCorrect() {
        //Given
        let cookingChoice = "cuisine^cuisine-american"
        let dietChoice = "Ketogenic"
        let allergyChoice = "Gluten-Free"
        parametersService.addParameters(0, cookingChoice)
        parametersService.addParameters(1, dietChoice)
        parametersService.addParameters(2, allergyChoice)
        //When
        parametersService.removeParameters(0, cookingChoice)
        parametersService.removeParameters(1, dietChoice)
        parametersService.removeParameters(2, allergyChoice)
        //Then
        XCTAssertTrue(ParametersRecording.cookingParameters.isEmpty)
        XCTAssertTrue(ParametersRecording.dietsParameters.isEmpty)
        XCTAssertTrue(ParametersRecording.alergiesParameters.isEmpty)
    }
    func testGivenThreeParametersSaveInUserDefault_WhenSearchParameters_ThenSearchResultIsCorrect() {
        //Given
        let cookingChoice = "cuisine^cuisine-american"
        let dietChoice = "Ketogenic"
        let allergyChoice = "Gluten-Free"
        parametersService.addParameters(0, cookingChoice)
        parametersService.addParameters(1, dietChoice)
        parametersService.addParameters(2, allergyChoice)

        //Then
        XCTAssertTrue(parametersService.searchParametersInConstant(cookingChoice))
        XCTAssertTrue(parametersService.searchParametersInConstant(dietChoice))
        XCTAssertTrue(parametersService.searchParametersInConstant(allergyChoice))
    }

    func testGivenThreeParametersSaveInUserDefault_WhenRemoveAll_ThenParametersIsEmptyInUserDefaultIsEmpty() {
        //Given
        let cookingChoice = "cuisine^cuisine-american"
        let dietChoice = "Ketogenic"
        let allergyChoice = "Gluten-Free"
        parametersService.addParameters(0, cookingChoice)
        parametersService.addParameters(1, dietChoice)
        parametersService.addParameters(2, allergyChoice)
        //When
        parametersService.clearParameters()
        //Then
        XCTAssertFalse(parametersService.searchParametersInConstant(cookingChoice))
        XCTAssertFalse(parametersService.searchParametersInConstant(dietChoice))
        XCTAssertFalse(parametersService.searchParametersInConstant(allergyChoice))
        XCTAssertTrue(ParametersRecording.cookingParameters.isEmpty)
        XCTAssertTrue(ParametersRecording.dietsParameters.isEmpty)
        XCTAssertTrue(ParametersRecording.alergiesParameters.isEmpty)
    }
}
