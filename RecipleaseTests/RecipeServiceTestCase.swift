//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 25/10/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeServiceTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetRecipeShouldPostFailedCallbackIfError() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipe { (error, recipe) in
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe { (error, recipe) in
        
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeIncorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPosterrorCallbackIfNoErrorAndCorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe { (error, recipe) in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(recipe)
            
            let ingredients = ["red onions","butter","oil","granulated sugar","beef broth","red wine","dijon mustard","thyme","bay leaf","baguette","grated Gruyère"]
            let smallImageUrls = ["https://lh3.googleusercontent.com/9QZqGWvmJlYDLZeJEWeFtXpDxNJDo9UUfScphUPtwxysuL26XdIUIuBf7jR_cKVl63ZfjG_euIgQCB_jNN_pUA=s90"]
            let recipeName = "Fabulous French Onion Soup"
            let totalTimeInSeconds = 1500
            let rating = 3
            
            XCTAssertEqual(ingredients, recipe?.matches[0].ingredients)
            XCTAssertEqual(smallImageUrls, recipe?.matches[0].smallImageUrls)
            XCTAssertEqual(recipeName, recipe?.matches[0].recipeName)
            XCTAssertEqual(totalTimeInSeconds, recipe?.matches[0].totalTimeInSeconds)
            XCTAssertEqual(rating, recipe?.matches[0].rating)
            expectation.fulfill()
        }
    }
}
