//
//  Products+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var ammount: Int16
    @NSManaged public var calories: Int16
    @NSManaged public var name: String?
    @NSManaged public var substitutes: [Products]?
    @NSManaged public var productshop: NSSet?
    @NSManaged public var productrecipe: NSSet?

}

// MARK: Generated accessors for productshop
extension Products {

    @objc(addProductshopObject:)
    @NSManaged public func addToProductshop(_ value: Shops)

    @objc(removeProductshopObject:)
    @NSManaged public func removeFromProductshop(_ value: Shops)

    @objc(addProductshop:)
    @NSManaged public func addToProductshop(_ values: NSSet)

    @objc(removeProductshop:)
    @NSManaged public func removeFromProductshop(_ values: NSSet)

}

// MARK: Generated accessors for productrecipe
extension Products {

    @objc(addProductrecipeObject:)
    @NSManaged public func addToProductrecipe(_ value: Recipe)

    @objc(removeProductrecipeObject:)
    @NSManaged public func removeFromProductrecipe(_ value: Recipe)

    @objc(addProductrecipe:)
    @NSManaged public func addToProductrecipe(_ values: NSSet)

    @objc(removeProductrecipe:)
    @NSManaged public func removeFromProductrecipe(_ values: NSSet)

}

extension Products : Identifiable {

}
