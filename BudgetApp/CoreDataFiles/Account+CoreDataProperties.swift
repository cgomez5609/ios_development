//
//  Account+CoreDataProperties.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/18/21.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var amount: Double
    @NSManaged public var parentUser: User?
    @NSManaged public var purchase: NSSet?

}

// MARK: Generated accessors for purchase
extension Account {

    @objc(addPurchaseObject:)
    @NSManaged public func addToPurchase(_ value: Purchases)

    @objc(removePurchaseObject:)
    @NSManaged public func removeFromPurchase(_ value: Purchases)

    @objc(addPurchase:)
    @NSManaged public func addToPurchase(_ values: NSSet)

    @objc(removePurchase:)
    @NSManaged public func removeFromPurchase(_ values: NSSet)

}

extension Account : Identifiable {

}
