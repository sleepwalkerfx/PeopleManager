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
        var student:Student

        do {
            if let existingStudent = try Student.findStudent(nationalIdNumber: nationalID, inContext: context) {
                student = existingStudent
            } else{
                student  =  Student(context: context)
            }
        }catch {
            throw error
        }
        
        student.name = name
        student.age = age
        student.year = year
        student.groupType = "Students"
        student.nationalIdentityNo = nationalID
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


}
// add people manager class // facade
// use this class to query for existing people,
