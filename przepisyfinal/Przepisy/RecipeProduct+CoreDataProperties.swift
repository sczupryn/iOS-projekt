//
//  RecipeProduct+CoreDataProperties.swift
//  Przepisy
//
//  Created by Jakub Jarosz on 13/06/2025.
//
//

import Foundation
import CoreData


extension RecipeProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeProduct> {
        return NSFetchRequest<RecipeProduct>(entityName: "RecipeProduct")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var product: Product?
    @NSManaged public var recipe: Recipe?
    
    
}

extension RecipeProduct : Identifiable {

}
