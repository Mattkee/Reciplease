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
    }
    //MARK: - Unit Tests
    func testGetSearchRecipeShouldPostFailedCallbackIfError() {
        // Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getSearchRecipe { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetSearchRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getSearchRecipe { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSearchRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getSearchRecipe { (error, recipe) in
        
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSearchRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeIncorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getSearchRecipe { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSearchRecipeShouldPosterrorCallbackIfNoErrorAndCorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getSearchRecipe { (error, recipe) in
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
    func testGetSearchRecipeWithParametersShouldPosterrorCallbackIfNoErrorAndCorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(router: Router<SearchRecipeAPI, SearchRecipe>(alamofireRequest: alamofireRequest))
        ParametersRecording.cookingParameters.append("American")
        ParametersRecording.alergiesParameters.append("Gluten")
        ParametersRecording.dietsParameters.append("Vegetarian")
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getSearchRecipe { (error, recipe) in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(recipe)

            expectation.fulfill()
        }
    }
    func testGetRecipeShouldPostFailedCallbackIfError() {
        // Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: RecipeFakeResponseData.error)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeRouter: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let recipeID = "French-Onion-Soup-2141595"

        recipeService.getRecipe(recipeID) { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let fakeResponse = FakeResponse(response: RecipeFakeResponseData.responseOK, data: nil, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeRouter: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let recipeID = "French-Onion-Soup-2141595"

        recipeService.getRecipe(recipeID) { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let fakeResponse = FakeResponse(response: RecipeFakeResponseData.responseKO, data: RecipeFakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeRouter: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let recipeID = "French-Onion-Soup-2141595"

        recipeService.getRecipe(recipeID) { (error, recipe) in
            
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: RecipeFakeResponseData.responseOK, data: RecipeFakeResponseData.recipeIncorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeRouter: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let recipeID = "French-Onion-Soup-2141595"

        recipeService.getRecipe(recipeID) { (error, recipe) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPosterrorCallbackIfNoErrorAndCorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: RecipeFakeResponseData.responseOK, data: RecipeFakeResponseData.recipeCorrectData, error: nil)
        let alamofireRequest = AlamofireRequestFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeRouter: Router<RecipeAPI, Recipe>(alamofireRequest: alamofireRequest))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let recipeID = "French-Onion-Soup-2141595"

        recipeService.getRecipe(recipeID) { (error, recipe) in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(recipe)
            
            let ingredientLines = ["Olive oil",
                               "4-6 yellow onions, thinly sliced",
                               "2 cloves garlic, minced",
                               "8 cups beef stock",
                               "½ cup dry white wine or chicken stock",
                               "1 teaspoon fresh thyme or ½ teaspoon dried thyme",
                               "6-8 slices French bread, toasted",
                               "2 cups Gruyere cheese, grated"]
            let source = "https://addapinch.com/french-onion-soup/"
            let recipeName = "French Onion Soup"
            let totalTime = "1 hr"
            let rating = 4
            
            XCTAssertEqual(ingredientLines, recipe?.ingredientLines)
            XCTAssertEqual(source, recipe?.source.sourceRecipeUrl)
            XCTAssertEqual(recipeName, recipe?.name)
            XCTAssertEqual(totalTime, recipe?.totalTime)
            XCTAssertEqual(rating, recipe?.rating)
            expectation.fulfill()
        }
    }
}
