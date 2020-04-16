//
//  Expense+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: Date?
    @NSManaged public var amount: Double
    @NSManaged public var caption: String?
    @NSManaged public var rowid: UUID?
    @NSManaged public var category: Category?

}
