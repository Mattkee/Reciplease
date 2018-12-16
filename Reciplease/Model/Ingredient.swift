//
//  Ingredient.swift
//  Reciplease
//
//  Created by Lei et Matthieu on 14/12/2018.
//  Copyright © 2018 Mattkee. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let ingredient = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return ingredient
    }
}
