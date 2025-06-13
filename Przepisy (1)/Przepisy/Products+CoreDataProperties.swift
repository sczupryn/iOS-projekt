//
//  Products+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var name: String?
    @NSManaged public var recipeProducts: RecipeProducts?
    @NSManaged public var shops: NSSet?
    
    public var shopArray: [Shops] {
        let set = shops as? Set<Shops> ?? []

         return set.sorted {
             $0.name! < $1.name!
         }

     }

}

// MARK: Generated accessors for shops
extension Products {

    @objc(addShopsObject:)
    @NSManaged public func addToShops(_ value: Shops)

    @objc(removeShopsObject:)
    @NSManaged public func removeFromShops(_ value: Shops)

    @objc(addShops:)
    @NSManaged public func addToShops(_ values: NSSet)

    @objc(removeShops:)
    @NSManaged public func removeFromShops(_ values: NSSet)

}

extension Products : Identifiable {

}
