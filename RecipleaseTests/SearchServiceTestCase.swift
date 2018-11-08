//
//  SearchServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 25/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import XCTest
@testable import Reciplease

class SearchServiceTestCase: XCTestCase {

    var recipeService : RecipeService!
    var recipeAPI : RecipeAPI!

    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
        recipeAPI = RecipeAPI()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testGivenInstanceOfRecipeService_WhenAccessingIt_ThenItExists() {
        
        XCTAssertNotNil(recipeService)
    }
    func testGivenBaseUrlOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        
        XCTAssertNotNil(recipeAPI.baseURL)
    }
    func testGivenPathUrlOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(recipeAPI.path)
    }
    func testGivenHttpMethodOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(recipeAPI.httpMethod)
    }
    func testGivenParametersOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(recipeAPI.parameters)
    }
    
}
