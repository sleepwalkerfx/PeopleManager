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

    //MARK: Students Operations
    func insertStudent(nationalID: String, name: String, age: Int16 , year: Int16) -> Student? {
        return try? Student.findOrCreateStudent(nationalID: nationalID, name: name, age: age, year: year, into: persistenceContainer.viewContext)
    }

    func fetchAllStudents() -> [Student] {
        let allStudents = Student.fetchAll(context: persistenceContainer.viewContext)
        return allStudents ?? [Student]()
    }
}
