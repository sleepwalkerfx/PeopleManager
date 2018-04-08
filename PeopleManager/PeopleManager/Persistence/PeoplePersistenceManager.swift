//
//  PeoplePersistenceManager.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import Foundation
import CoreData

class PeoplePersistenceManager {

    let persistentContainer: NSPersistentContainer!

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }

    convenience init() {
        self.init(container: AppDelegate.persistentConainer)
    }

    func saveContext() {
        if self.persistentContainer.viewContext.hasChanges {
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    //MARK: Students Operations
    @discardableResult
    func createStudent(nationalID: String, name: String, age: Int16 , year: Int16) throws -> Student {
        do {
            return try Student.createStudent(nationalID: nationalID, name: name, age: age, year: year, into: persistentContainer.viewContext)
        } catch PersonError.idAlreadyExist {
            print("USER ALREADY EXIST EXCEPTION!")
            throw PersonError.idAlreadyExist
        } catch {
            throw error
        }
    }

    func fetchAllStudents() -> [Student] {
        let allStudents = Student.fetchAll(context: persistentContainer.viewContext)
        return allStudents ?? [Student]()
    }

    //MARK: Teachers Operations
    @discardableResult
    func createTeacher(nationalID: String, name: String, age: Int16 , salary: Float, subject:String) throws -> Teacher {
        do {
            return try Teacher.createTeacher(nationalID: nationalID, name: name, age: age, salary: salary, subject: subject, into: persistentContainer.viewContext)
        } catch PersonError.idAlreadyExist {
            throw PersonError.idAlreadyExist
        }catch {
            throw error
        }
    }

    func fetchAllTeachers() -> [Student] {
        let allStudents = Student.fetchAll(context: persistentContainer.viewContext)
        return allStudents ?? [Student]()
    }


}
