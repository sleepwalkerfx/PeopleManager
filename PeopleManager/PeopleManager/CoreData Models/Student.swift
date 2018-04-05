//
//  Student.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import CoreData

class Student: Person {

    class func findOrCreateStudent(nationalID: String, name: String, age: Int16, year: Int16, into context: NSManagedObjectContext) throws -> Student {
        do {
            if let student = try Student.findStudent(nationalIdNumber: nationalID, inContext: context) {
                return student
            }

        }catch {
            throw error
        }
        
        let student = Student(context: context)
        student.name = name
        student.age = age
        student.year = year
        return student
    }

    class func findStudent(nationalIdNumber: String, inContext context: NSManagedObjectContext) throws -> Student? {
        let request : NSFetchRequest<Student> = Student.fetchRequest()
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


    class func fetchAll(context: NSManagedObjectContext) -> [Student]? {
        let request:NSFetchRequest<Student> = Student.fetchRequest()
        let results = try? context.fetch(request)
        return results
    }

    class func remove( student: Student, from context: NSManagedObjectContext) {
        context.delete(student)
    }

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error \(error)")
            }
        }

    }
}
// add people manager class // facade
// use this class to query for existing people,
