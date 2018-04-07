//
//  Person.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import CoreData

enum PersonError: Error {
    case idAlreadyExist
}

class Person: NSManagedObject {
    
//    class func fetchAll <T:NSManagedObject> (context: NSManagedObjectContext) -> [T]? {
//        let request:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
//        let results = try? context.fetch(request)
//        return results
//    }
    class func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }

    class func findPerson(nationalIdNumber: String, inContext context: NSManagedObjectContext) throws -> Person? {
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "nationalIdentityNo = %@", nationalIdNumber)

        do {
            let results = try  context.fetch(request)
            if results.count > 0 {
                assert(results.count == 1, "Database is inconsistent. Contains multiple person objects with same national ID number")
                return results[0]
            }
        } catch {
            throw error
        }
        return nil
    }

    class func remove( person: Person, from context: NSManagedObjectContext) {
        context.delete(person)
    }
}
