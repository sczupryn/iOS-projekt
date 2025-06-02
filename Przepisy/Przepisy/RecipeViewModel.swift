//
//  RecipeViewModel.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

import Foundation
import CoreData
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "YourModelName")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        fetchRecipes()
    }
    
    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            recipes = try container.viewContext.fetch(request)
        } catch {
            print("Błąd pobierania przepisów: \(error)")
        }
    }
    
    func addRecipe(name: String, ingredients: String, instruction: String, preparationTime: Int, difficulty: Int) {
        let newRecipe = Recipe(context: container.viewContext)
        newRecipe.name = name
        newRecipe.ingredients = ingredients
        newRecipe.instruction = instruction
        newRecipe.preparationTime = Int16(preparationTime)
        newRecipe.difficulty = Int16(difficulty)
        saveContext()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        container.viewContext.delete(recipe)
        saveContext()
    }
    
    func saveContext() {
        do {
            try container.viewContext.save()
            fetchRecipes()
        } catch {
            print("Błąd zapisu do Core Data: \(error)")
        }
    }
}

//#Preview {
    //RecipeViewModel()
//}
