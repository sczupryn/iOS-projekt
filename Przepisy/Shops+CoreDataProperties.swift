//
//  Shops+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//
//

import Foundation
import CoreData


extension Shops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shops> {
        return NSFetchRequest<Shops>(entityName: "Shops")
    }

    @NSManaged public var name: String?
    @NSManaged public var localization: String?
    @NSManaged public var products: [Products]?
    @NSManaged public var shopproduct: NSSet?

}

// MARK: Generated accessors for shopproduct
extension Shops {

    @objc(addShopproductObject:)
    @NSManaged public func addToShopproduct(_ value: Products)

    @objc(removeShopproductObject:)
    @NSManaged public func removeFromShopproduct(_ value: Products)

    @objc(addShopproduct:)
    @NSManaged public func addToShopproduct(_ values: NSSet)

    @objc(removeShopproduct:)
    @NSManaged public func removeFromShopproduct(_ values: NSSet)

}

extension Shops : Identifiable {

}
