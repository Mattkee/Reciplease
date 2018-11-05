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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGivenInstanceOfRecipeService_WhenAccessingIt_ThenItExists() {
        let recipeService = RecipeService()
        
        XCTAssertNotNil(recipeService)
    }
    func testGivenInstanceOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        let recipeAPI = RecipeAPI()
        
        XCTAssertNotNil(recipeAPI)
    }
    func testGivenBaseUrlOfRecipeAPI_WhenAccessingIt_ThenItExists() {
        let recipeAPI = RecipeAPI()
        
        XCTAssertNotNil(recipeAPI.baseURL)
    }
}
