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

    class func createStudent(nationalID: String, name: String, age: Int16, year: Int16, into context: NSManagedObjectContext) throws -> Student {
        do {
            if try self.findPerson(nationalIdNumber: nationalID, inContext: context) != nil{
                print("User already exists!")
                throw PersonError.idAlreadyExist
            }
        }catch {
            throw error
        }
        let student  =  Student(context: context)
        student.name = name
        student.age = age
        student.year = year
        student.groupType = "Students"
        student.nationalIdentityNo = nationalID
        return student
    }


    class func fetchAll(context: NSManagedObjectContext) -> [Student]? {
        let request:NSFetchRequest<Student> = Student.fetchRequest()
        let results = try? context.fetch(request)
        return results
    }


}
// add people manager class // facade
// use this class to query for existing people,
