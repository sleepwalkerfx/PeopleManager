//
//  Constants.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/8/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import Foundation

struct Constants {

    struct StudentFormKeys {
        static let SectionPersonalInfo = "Personal Information"
        static let IdNumberTitle = "ID Number"
        static let IdNumberPlaceholder = "National ID Card number"
        static let IdNumberTag = "student_id"

        static let NameRowTitle = "Name"
        static let NamePlaceholder = "Enter your name here"
        static let NameTag = "student_name"

        static let AgeRowTitle = "Age"
        static let AgePlaceholder = "Enter your age here"
        static let AgeTag = "student_age"

        static let SectionOtherDetails = "Other Details"
        static let YearTitle = "Year"
        static let YearPlaceholder = "Course Year"
        static let YearTag = "student_year"
    }

    struct TeacherFormKeys {
        static let SectionPersonalInfo = "Personal Information"
        static let IdNumberTitle = "ID Number"
        static let IdNumberPlaceholder = "Enter ID number here"
        static let IdNumberTag = "teacher_id"

        static let NameRowTitle = "Name"
        static let NamePlaceholder = "Enter your name here"
        static let NameTag = "teacher_name"

        static let AgeRowTitle = "Age"
        static let AgePlaceholder = "Enter your age here"
        static let AgeTag = "teacher_age"

        static let SectionOtherDetails = "Other Details"
        static let SalaryTitle = "Salary"
        static let SalaryPlaceholder = "Monthly Salary"
        static let SalaryTag = "teacher_salary"

        static let SubjectTitle = "Subject"
        static let SubjectPlaceholder = "Main Subject"
        static let SubjectTag = "teacher_subject"
    }

    struct StudentProfile {
        static let Title = "STUDENT PROFILE"
        static let EditTitle = "Edit Student"
    }

    struct TeacherProfile {
        static let Title = "TEACHER PROFILE"
        static let EditTitle = "Edit Teacher"
    }

    struct StoryboardId {
        static let EditStudentNavId = "editStudentNC"
        static let EditTeacherNavId = "editTeacherNC"
    }

    struct CoreDataIdentifiers {
        static let TeacherGroupType = "Teachers"
        static let StudentGroupType = "Students"

    }

    struct ErrorMessages {
        static let MissingInfoErrorTitle = "Missing Info"
        static let NoIdError = "No ID given"
        static let NoNameError = "No name given"
        static let NoAgeError = "No age given"
        static let NoSalaryError = "No salary given"
        static let NoSubjectError = "No subject given"
        static let NoYearError = "No year given"
        static let UserExistsError = "User Exists"
        static let UserExistsErrorMessage = "A user with this national id number already exists"
        static let UnknownError = "Unknown Error"
        static let UserCreationFailedError = "User creation failed"
    }
}
