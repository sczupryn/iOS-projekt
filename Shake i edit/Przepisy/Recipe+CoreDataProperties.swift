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
    @NSManaged public var products: NSSet?
    
    public var productArray: [Product] {
        let set = products as? Set<Product> ?? []

         return set.sorted {
             $0.name! < $1.name!
         }

     }
}

// MARK: Generated accessors for products
extension Recipe {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: RecipeProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: RecipeProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Recipe : Identifiable {

}
