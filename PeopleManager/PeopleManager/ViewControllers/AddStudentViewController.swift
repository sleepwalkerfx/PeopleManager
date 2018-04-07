//
//  AddPeopleViewController.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import Eureka

class AddStudentViewController: FormViewController {

    private var isEditMode:Bool = false
    var editingStudent: Student? {
        didSet{
            if editingStudent != nil {
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
    }

    private func configureForm() {
        form +++ Section("Personal Information")
            <<< TextRow(){
                $0.title = "ID Number"
                $0.placeholder = "Enter ID number here"
                $0.tag = "student_id"
                $0.value = editingStudent?.nationalIdentityNo
                if isEditMode {
                    $0.disabled = true
                }
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter your name here"
                row.tag = "student_name"
                row.value = editingStudent?.name
            }
            <<< IntRow(){
                $0.title = "Age"
                $0.placeholder = "Enter your age here"
                $0.tag = "student_age"
                if isEditMode {
                    $0.value = Int(editingStudent!.age)
                }
            }
            +++ Section("Other Details")
            <<< IntRow(){
                $0.title = "Year"
                $0.placeholder = "Course Year"
                $0.tag = "student_year"
                if isEditMode {
                    $0.value = Int(editingStudent!.year)
                }        }

    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {

        guard let studentDetails = getStudentDetails() else {
            return
        }
        if isEditMode {
            updateExistingStudent(studentDetails: studentDetails)
        } else {
            createStudent(studentDetails: studentDetails)
        }
    }

    typealias StudentdetailsType = (nationalID:String,name:String,age:Int16,year:Int16)

    private func getStudentDetails() -> (StudentdetailsType)? {
        let idRow:TextRow? = form.rowBy(tag: "student_id")
        let nameRow:TextRow? = form.rowBy(tag: "student_name")
        let ageRow:IntRow? = form.rowBy(tag: "student_age")
        let yearRow:IntRow? = form.rowBy(tag: "student_year")

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
        guard let year = yearRow?.value else {
            print("no salary given")
            return nil
        }

        return(id,name,Int16(age),Int16(year))
    }

    private func createStudent(studentDetails:StudentdetailsType) {
        let manager = PeoplePersistenceManager()
        manager.createStudent(nationalID: studentDetails.nationalID, name: studentDetails.name, age: studentDetails.age, year: studentDetails.year)
        manager.saveContext()
        dismissVC()
    }

    private func updateExistingStudent(studentDetails:StudentdetailsType) {

        editingStudent?.nationalIdentityNo = studentDetails.nationalID
        editingStudent?.name = studentDetails.name
        editingStudent?.age = studentDetails.age
        editingStudent?.year = studentDetails.year
        try? AppDelegate.viewContext.save()
        dismissVC()
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismissVC()
    }

    private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
