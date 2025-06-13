//
//  RecipeProducts+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//
//

import Foundation
import CoreData


extension RecipeProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeProducts> {
        return NSFetchRequest<RecipeProducts>(entityName: "RecipeProducts")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var products: Products?
    @NSManaged public var recipes: Recipes?

}

extension RecipeProducts : Identifiable {

}
