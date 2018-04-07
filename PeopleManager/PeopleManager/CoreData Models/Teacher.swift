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

    @discardableResult
    class func insert(nationalIdNo:String, name: String, age: Int16, salry: Float, subject: String, into context: NSManagedObjectContext) -> Teacher {
        let teacher = Teacher(context: context)
        teacher.nationalIdentityNo = nationalIdNo
        teacher.name = name
        teacher.age = age
        teacher.subject = subject
        teacher.groupType = "Teachers"
        return teacher
    }
}
