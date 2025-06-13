//
//  Shop+CoreDataProperties.swift
//  Przepisy
//
//  Created by Jakub Jarosz on 13/06/2025.
//
//

import Foundation
import CoreData


extension Shop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shop> {
        return NSFetchRequest<Shop>(entityName: "Shop")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var products: NSSet?

    public var prodctArray: [Product] {
        let set = products as? Set<Product> ?? []
        
        return set.sorted {
            $0.name! < $1.name!
        }
        
    }}

// MARK: Generated accessors for products
extension Shop {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Shop : Identifiable {

}
