//
//  IngredientServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 08/01/2019.
//  Copyright © 2019 Mattkee. All rights reserved.
//

import XCTest
@testable import Reciplease

class IngredientServiceTestCase: XCTestCase {

    var ingredientService: IngredientService!

    override func setUp() {
        super.setUp()
        ingredientService = IngredientService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        ingredientService.clear()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenNoIngredient_WhenaddingIngredients_ThenIngredientsAreInConstantIngredient() {
        //Given
        let text = "onion, soup"
        //When
        ingredientService.addIngredient(text)
        //Then
        let ingredient = Constant.ingredients
        XCTAssertEqual(ingredient[0], "onion")
        XCTAssertEqual(ingredient[1], "soup")
    }

    func testGivenNoIngredient_WhenaddingIngredientsWithoutTextEspace_ThenIngredientsAreInConstantIngredient() {
        //Given
        let text = "onion,soup"
        //When
        ingredientService.addIngredient(text)
        //Then
        let ingredient = Constant.ingredients
        XCTAssertEqual(ingredient[0], "onion")
        XCTAssertEqual(ingredient[1], "soup")
    }

    func testGivenNoIngredient_WhenaddingOneIngredient_ThenIngredientIsInConstantIngredient() {
        //Given
        let text = "onion"
        //When
        ingredientService.addIngredient(text)
        //Then
        let ingredient = Constant.ingredients
        XCTAssertEqual(ingredient[0], "onion")
    }

    func testGivenTwoIngredients_WhenRemoveOneIngredient_ThenIngredientIsRemoveInConstantIngredient() {
        //Given
        let text = "onion, soup"
        ingredientService.addIngredient(text)
        //When
        ingredientService.removeIngredient(at: 1)
        //Then
        let ingredient = Constant.ingredients
        let allIngredient = ingredient.joined()
        XCTAssertEqual(allIngredient, "onion")
    }
    func testGivenTwoIngredients_WhenRemoveAll_ThenConstantIngredientIsEmpty() {
        //Given
        let text = "onion, soup"
        ingredientService.addIngredient(text)
        //When
        ingredientService.clear()
        //Then
        let ingredient = Constant.ingredients
        XCTAssertTrue(ingredient.isEmpty)
    }
}
