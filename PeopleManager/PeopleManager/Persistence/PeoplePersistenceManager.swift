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

    let persistenceContainer: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.persistenceContainer = container
    }

    convenience init() {
        self.init(container: AppDelegate.persistentConainer)
    }

    func saveContext() {
        if self.persistenceContainer.viewContext.hasChanges {
            do {
                try self.persistenceContainer.viewContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    //MARK: Students Operations

    @discardableResult
    func createStudent(nationalID: String, name: String, age: Int16 , year: Int16) -> Student? {
        do {
            return try Student.createStudent(nationalID: nationalID, name: name, age: age, year: year, into: persistenceContainer.viewContext)
        } catch PersonError.idAlreadyExist {
            print("USER EXIST EXCEPTION!")
        } catch {
        }
        return nil
    }

    func fetchAllStudents() -> [Student] {
        let allStudents = Student.fetchAll(context: persistenceContainer.viewContext)
        return allStudents ?? [Student]()
    }

    //MARK: Teachers Operations
    @discardableResult
    func createTeacher(nationalID: String, name: String, age: Int16 , salary: Float, subject:String) -> Teacher? {
        return try? Teacher.createTeacher(nationalID: nationalID, name: name, age: age, salary: salary, subject: subject, into: persistenceContainer.viewContext)
    }

    func fetchAllTeachers() -> [Student] {
        let allStudents = Student.fetchAll(context: persistenceContainer.viewContext)
        return allStudents ?? [Student]()
    }


}
