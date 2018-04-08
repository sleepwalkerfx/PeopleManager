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
        sut = PeoplePersistenceManager()

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
        //Assert save is called via notification (wait)
        expectation(forNotification: Notification.Name.NSManagedObjectContextDidSave, object: nil, handler: nil)
        sut.saveContext()
        //This test will fail on 2nd time, since same object is being added, which will not be saved
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
