//
//  Shops+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//
//

import Foundation
import CoreData


extension Shops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shops> {
        return NSFetchRequest<Shops>(entityName: "Shops")
    }

    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?
    
    public var productArray: [Products] {
        let set = products as? Set<Products> ?? []

         return set.sorted {
             $0.name! < $1.name!
         }

     }

}

// MARK: Generated accessors for products
extension Shops {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Products)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Products)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Shops : Identifiable {

}
