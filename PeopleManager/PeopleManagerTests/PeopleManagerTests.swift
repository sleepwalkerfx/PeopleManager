//
//  PeopleManagerTests.swift
//  PeopleManagerTests
//
//  Created by Rukshan Marapana on 4/4/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import XCTest
import CoreData

@testable import PeopleManager

class PeopleManagerTests: XCTestCase {

    var sut:PeoplePersistenceManager!
    override func setUp() {
        super.setUp()
        initStubs()

         sut = PeoplePersistenceManager(container: mockPersistantContainer)

        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testStudentCreate() {

        //Give a todo item
        let name = "student name"
        let age = 22
        let id = "193848v"
        let year = 2018

        _ = expectationForSaveNotification()
        sut.createStudent(nationalID: id, name: name, age: Int16(age), year: Int16(year))
        //When save


        //Assert save is called via notification (wait)
        
        expectation(forNotification: Notification.Name.NSManagedObjectContextDidSave, object: nil, handler: nil)

        sut.saveContext()
        waitForExpectations(timeout: 1.0, handler: nil)


    }

    //MARK:  In-memory Persistent Store (Mock)
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PeopleManager", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Creating failed \(error)")
            }
        }
        return container
    }()


    //MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification)->())?

    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }

    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }

    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }
}


//MARK: Creat some fakes
extension PeopleManagerTests {

    func initStubs() {

        func insertStudent( name: String, age: Int16, id: String, year: Int16 ) -> Student? {

            let obj = NSEntityDescription.insertNewObject(forEntityName: "Student", into: mockPersistantContainer.viewContext)

            obj.setValue("Name 1", forKey: "name")
            obj.setValue(12, forKey: "age")
            obj.setValue("1", forKey: "nationalIdentityNo")
            obj.setValue(2018, forKey: "year")
            obj.setValue("Students",forKey:"groupType")

            return obj as? Student
        }
        _ = insertStudent(name: "Name 1", age: 12, id: "1", year: 2018)
        _ = insertStudent(name: "Name 2", age: 13, id: "2", year: 2018)
        _ = insertStudent(name: "Name 3", age: 14, id: "3", year: 2018)
        _ = insertStudent(name: "Name 4", age: 15, id: "4", year: 2018)
        _ = insertStudent(name: "Name 5", age: 16, id: "5", year: 2018)

        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }

    }

    func flush() {

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }

        try! mockPersistantContainer.viewContext.save()

    }

}

