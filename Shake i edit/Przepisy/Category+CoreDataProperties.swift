//
//  Category+CoreDataProperties.swift
//  Przepisy
//
//  Created by student on 03/06/2025.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var recipes: Recipes?
    
}

extension Category : Identifiable {

}
