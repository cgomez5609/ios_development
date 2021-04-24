//
//  User+CoreDataProperties.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/18/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: Int16
    @NSManaged public var username: String?
    @NSManaged public var account: Account?

}

extension User : Identifiable {

}
