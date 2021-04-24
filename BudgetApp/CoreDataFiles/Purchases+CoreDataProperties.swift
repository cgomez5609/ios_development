//
//  Purchases+CoreDataProperties.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/18/21.
//
//

import Foundation
import CoreData


extension Purchases {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchases> {
        return NSFetchRequest<Purchases>(entityName: "Purchases")
    }

    @NSManaged public var company: String?
    @NSManaged public var purchaseAmount: Double
    @NSManaged public var parentAccount: Account?

}

extension Purchases : Identifiable {

}
