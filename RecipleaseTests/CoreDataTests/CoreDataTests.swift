//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Lei et Matthieu on 29/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {

    //MARK: - Vars
    var container: NSPersistentContainer!

    override func setUp() {
        container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        FavoriteRecipe.deleteAll()
        container = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Helper Methods
    private func insertFavoriteRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteRecipeItem = FavoriteRecipe(context: managedObjectContext)
        newFavoriteRecipeItem.name = "Recipe Test"
        newFavoriteRecipeItem.id = "Recipe Test"
        newFavoriteRecipeItem.totalTime = "Recipe Test"
        newFavoriteRecipeItem.rating = "Recipe Test"
        newFavoriteRecipeItem.image = "Recipe Test"
        newFavoriteRecipeItem.sourceUrl = "Recipe Test"
        newFavoriteRecipeItem.ingredientsDetail = "Recipe Test"
        let ingredientList = ["Recipe Test","Recipe Test","Recipe Test","Recipe Test"]
        
        ingredientList.forEach { element in
            let ingredient = Ingredient(context: managedObjectContext)
            ingredient.name = element
            ingredient.recipe = newFavoriteRecipeItem
        }
    }
    //MARK: - Unit Tests
    func testInsertManyFavoriteRecipeItemsInPersistentContainer() {
        for _ in 0 ..< 100000 {
            insertFavoriteRecipeItem(into: container.newBackgroundContext())
        }
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }

    func testDeleteAllFavoriteRecipeItemsInPersistentContainer() {
        FavoriteRecipe.deleteAll()
        XCTAssertEqual(FavoriteRecipe.all, [])
    }
    func testGivenRecipeToSave_WhenSaving_ThenRecipeIsSave() {
        guard let data = RecipeFakeResponseData.recipeCorrectData else {
            return
        }
        guard let recipe = try? JSONDecoder().decode(Recipe.self, from: data) else {
            return
        }
        let ingredientList = "recipe test, recipe test"
        FavoriteRecipe.save(recipe, ingredientList)
        XCTAssertNotEqual(FavoriteRecipe.all, [])
    }
    func testGivenSearchSpecificRecipeInCoreData_WhenRecoverThisRecipe_ThenSearchResponseIsOk() {
        guard let data = RecipeFakeResponseData.recipeCorrectData else {
            return
        }
        guard let recipe = try? JSONDecoder().decode(Recipe.self, from: data) else {
            return
        }
        let ingredientList = "recipe test, recipe test"
        FavoriteRecipe.save(recipe, ingredientList)
        
        let name = recipe.name
        let favoriteRecipe = FavoriteRecipe.fetch(name)
        XCTAssertEqual(favoriteRecipe[0].name, recipe.name)
    }
    func testGivenRecipeInCoreData_WhenRemoveThisRecipe_ThenRecipeIsDeleteOnCoreData() {
        guard let data = RecipeFakeResponseData.recipeCorrectData else {
            return
        }
        guard let recipe = try? JSONDecoder().decode(Recipe.self, from: data) else {
            return
        }
        let ingredientList = "recipe test, recipe test"
        FavoriteRecipe.save(recipe, ingredientList)
        
        let id = recipe.id
        FavoriteRecipe.remove(id)
        XCTAssertEqual(FavoriteRecipe.all, [])
    }
}
