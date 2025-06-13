//
//  Product+CoreDataProperties.swift
//  Przepisy
//
//  Created by Jakub Jarosz on 13/06/2025.
//
//

import Foundation
import CoreData


extension Product {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }
    
    @NSManaged public var calories: Int16
    @NSManaged public var name: String?
    @NSManaged public var recipeProducts: NSSet?
    @NSManaged public var shops: NSSet?
    
    public var shopArray: [Shop] {
        let set = shops as? Set<Shop> ?? []
        
        return set.sorted {
            $0.name! < $1.name!
        }
        
    }
    public var recipeProductsArray: [RecipeProduct] {
        let set = recipeProducts as? Set<RecipeProduct> ?? []
        
        return set.sorted {
            $0.product?.name ?? "" < $1.product?.name ?? ""
        }
        
    }
}

// MARK: Generated accessors for recipeProducts
extension Product {

    @objc(addRecipeProductsObject:)
    @NSManaged public func addToRecipeProducts(_ value: RecipeProduct)

    @objc(removeRecipeProductsObject:)
    @NSManaged public func removeFromRecipeProducts(_ value: RecipeProduct)

    @objc(addRecipeProducts:)
    @NSManaged public func addToRecipeProducts(_ values: NSSet)

    @objc(removeRecipeProducts:)
    @NSManaged public func removeFromRecipeProducts(_ values: NSSet)

}

// MARK: Generated accessors for shops
extension Product {

    @objc(addShopsObject:)
    @NSManaged public func addToShops(_ value: Shop)

    @objc(removeShopsObject:)
    @NSManaged public func removeFromShops(_ value: Shop)

    @objc(addShops:)
    @NSManaged public func addToShops(_ values: NSSet)

    @objc(removeShops:)
    @NSManaged public func removeFromShops(_ values: NSSet)

}

extension Product : Identifiable {

}
