//
//  Recipe+CoreDataProperties.swift
//  Przepisy
//
//  Created by Jakub Jarosz on 13/06/2025.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var difficulty: Int16
    @NSManaged public var instruction: String?
    @NSManaged public var name: String?
    @NSManaged public var preparationTime: Int16
    @NSManaged public var recipeProducts: NSSet?  // <- To Many -> RecipeProduct

    public var recipeProductsArray: [RecipeProduct] {
        let set = recipeProducts as? Set<RecipeProduct> ?? []
        return set.sorted {
            ($0.product?.name ?? "") < ($1.product?.name ?? "")
        }
    }

    public var productArray: [Product] {
        recipeProductsArray.compactMap { $0.product }
            .sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
}

// MARK: Generated accessors for recipeProducts
extension Recipe {

    @objc(addRecipeProductsObject:)
    @NSManaged public func addToRecipeProducts(_ value: RecipeProduct)

    @objc(removeRecipeProductsObject:)
    @NSManaged public func removeFromRecipeProducts(_ value: RecipeProduct)

    @objc(addRecipeProducts:)
    @NSManaged public func addToRecipeProducts(_ values: NSSet)

    @objc(removeRecipeProducts:)
    @NSManaged public func removeFromRecipeProducts(_ values: NSSet)
}


extension Recipe : Identifiable { }
