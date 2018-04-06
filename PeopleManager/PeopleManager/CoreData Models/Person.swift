//
//  Person.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import CoreData

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
}
