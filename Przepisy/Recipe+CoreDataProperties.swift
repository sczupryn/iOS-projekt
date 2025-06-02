//
//  Recipe+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var difficulty: Int16
    @NSManaged public var ingredients: String?
    @NSManaged public var instruction: String?
    @NSManaged public var name: String?
    @NSManaged public var preparationTime: Int16
    @NSManaged public var recipeproduct: NSSet?
    
    public var productArray: [Products] {
        let set = recipeproduct as? Set<Products> ?? []
        
        return set.sorted {
            $0.name! < $1.name!
        }
    }

}

// MARK: Generated accessors for recipeproduct
extension Recipe {

    @objc(addRecipeproductObject:)
    @NSManaged public func addToRecipeproduct(_ value: Products)

    @objc(removeRecipeproductObject:)
    @NSManaged public func removeFromRecipeproduct(_ value: Products)

    @objc(addRecipeproduct:)
    @NSManaged public func addToRecipeproduct(_ values: NSSet)

    @objc(removeRecipeproduct:)
    @NSManaged public func removeFromRecipeproduct(_ values: NSSet)

}

extension Recipe : Identifiable {

}
