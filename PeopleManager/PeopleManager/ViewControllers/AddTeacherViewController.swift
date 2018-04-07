//
//  AddTeacherViewController.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/7/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import Eureka

class AddTeacherViewController: FormViewController {

    private var isEditMode:Bool = false
    var editingTeacher: Teacher? {
        didSet{
            if editingTeacher != nil {
                isEditMode = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isEditMode {
            print("Edit mode")
        } else {
            print("Normal mode")
        }
        configureForm()
        // Do any additional setup after loading the view.
    }

    private func configureForm() {
        form +++ Section("Personal Information")
            <<< TextRow(){
                $0.title = "ID Number"
                $0.placeholder = "Enter ID number here"
                $0.tag = "teacher_id"
                $0.value = editingTeacher?.nationalIdentityNo
                if isEditMode {
                    $0.disabled = true
                }
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter your name here"
                row.tag = "teacher_name"
                row.value = editingTeacher?.name
            }
            <<< IntRow(){
                $0.title = "Age"
                $0.placeholder = "Enter your age here"
                $0.tag = "teacher_age"
                if isEditMode {
                $0.value = Int(editingTeacher!.age)
                }
            }
            +++ Section("Other Details")
            <<< DecimalRow(){
                $0.title = "Salary"
                $0.placeholder = "Monthly salary"
                $0.tag = "teacher_salary"
                if isEditMode {
                    $0.value = Double(editingTeacher!.salary)
                }
            }
            <<< TextRow(){
                $0.title = "Subject"
                $0.placeholder = "Main Subject"
                $0.tag = "teacher_subject"
                $0.value = editingTeacher?.subject
        }
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismissVC()
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {

        guard let teacherDetails = getTeacherDetails() else {
            return
        }
        if isEditMode {
            updateExistingTeacher(teacherDetails: teacherDetails)
        } else {
            createTeacher(teacherDetails: teacherDetails)
        }
    }

    typealias TeacherdetailsType = (nationalID:String,name:String,age:Int16,salary:Float,subject:String)

    private func getTeacherDetails() -> (TeacherdetailsType)? {
        let idRow:TextRow? = form.rowBy(tag: "teacher_id")
        let nameRow:TextRow? = form.rowBy(tag: "teacher_name")
        let ageRow:IntRow? = form.rowBy(tag: "teacher_age")
        let salaryRow:DecimalRow? = form.rowBy(tag: "teacher_salary")
        let subjectRow:TextRow? = form.rowBy(tag: "teacher_subject")

        guard let id = idRow?.value else {
            print("no id given")
            return nil
        }
        guard let name = nameRow?.value else {
            print("no name given")
            return nil
        }
        guard let age = ageRow?.value else {
            print("no age given")
            return nil
        }
        guard let salary = salaryRow?.value else {
            print("no salary given")
            return nil
        }
        guard let subject = subjectRow?.value else {
            print("no subject given")
            return nil
        }
        return (id,name,Int16(age) ,Float(salary),subject)
    }

    private func createTeacher(teacherDetails:TeacherdetailsType) {
        let manager = PeoplePersistenceManager()
        manager.createTeacher(nationalID: teacherDetails.nationalID, name: teacherDetails.name, age: teacherDetails.age, salary: teacherDetails.salary, subject: teacherDetails.subject)
        manager.saveContext()
        dismissVC()
    }

    private func updateExistingTeacher(teacherDetails:TeacherdetailsType) {

        editingTeacher?.nationalIdentityNo = teacherDetails.nationalID
        editingTeacher?.name = teacherDetails.name
        editingTeacher?.age = teacherDetails.age
        editingTeacher?.salary = teacherDetails.salary
        editingTeacher?.subject = teacherDetails.subject
        try? AppDelegate.viewContext.save()
        dismissVC()
    }

    private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
