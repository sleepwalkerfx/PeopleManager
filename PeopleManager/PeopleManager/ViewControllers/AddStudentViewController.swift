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
        configureForm()
    }

    private func configureForm() {
        form +++ Section(Constants.StudentFormKeys.SectionPersonalInfo)
            <<< TextRow(){
                $0.title = Constants.StudentFormKeys.IdNumberTitle
                $0.placeholder = Constants.StudentFormKeys.IdNumberPlaceholder
                $0.tag = Constants.StudentFormKeys.IdNumberTag
                $0.value = editingStudent?.nationalIdentityNo
                if isEditMode {
                    $0.disabled = true
                }
            }
            <<< TextRow(){ row in
                row.title = Constants.StudentFormKeys.NameRowTitle
                row.placeholder = Constants.StudentFormKeys.NamePlaceholder
                row.tag = Constants.StudentFormKeys.NameTag
                row.value = editingStudent?.name
            }
            <<< IntRow(){
                $0.title = Constants.StudentFormKeys.AgeRowTitle
                $0.placeholder = Constants.StudentFormKeys.AgePlaceholder
                $0.tag = Constants.StudentFormKeys.AgeTag
                if isEditMode {
                    $0.value = Int(editingStudent!.age)
                }
            }
            +++ Section(Constants.StudentFormKeys.SectionOtherDetails)
            <<< IntRow(){
                $0.title = Constants.StudentFormKeys.YearTitle
                $0.placeholder = Constants.StudentFormKeys.YearPlaceholder
                $0.tag = Constants.StudentFormKeys.YearTag
                if isEditMode {
                    $0.value = Int(editingStudent!.year)
                }
        }
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
        let idRow:TextRow? = form.rowBy(tag: Constants.StudentFormKeys.IdNumberTag)
        let nameRow:TextRow? = form.rowBy(tag: Constants.StudentFormKeys.NameTag)
        let ageRow:IntRow? = form.rowBy(tag: Constants.StudentFormKeys.AgeTag)
        let yearRow:IntRow? = form.rowBy(tag: Constants.StudentFormKeys.YearTag)

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
