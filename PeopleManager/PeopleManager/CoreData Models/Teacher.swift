//
//  Teacher.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import CoreData

class Teacher: Person {

    class func createTeacher(nationalID: String, name: String, age: Int16, salary: Float, subject:String, into context: NSManagedObjectContext) throws -> Teacher {
        do {
            if try findPerson(nationalIdNumber: nationalID, inContext: context) != nil {
                print("User already exists with ID!")
                throw PersonError.idAlreadyExist
            }
        }catch {
            throw error
        }
        let teacher  =  Teacher(context: context)
        teacher.name = name
        teacher.age = age
        teacher.salary = salary
        teacher.subject = subject
        teacher.groupType = "Teachers"
        teacher.nationalIdentityNo = nationalID
        return teacher
    }

    class func fetchAll(context: NSManagedObjectContext) -> [Teacher]? {
        let request:NSFetchRequest<Teacher> = Teacher.fetchRequest()
        let results = try? context.fetch(request)
        return results
    }
}
