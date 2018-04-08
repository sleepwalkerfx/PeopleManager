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
        configureForm()
    }

    private func configureForm() {
        form +++ Section(Constants.TeacherFormKeys.SectionPersonalInfo)
            <<< TextRow(){
                $0.title = Constants.TeacherFormKeys.IdNumberTitle
                $0.placeholder = Constants.TeacherFormKeys.IdNumberPlaceholder
                $0.tag = Constants.TeacherFormKeys.IdNumberTag
                $0.value = editingTeacher?.nationalIdentityNo
                if isEditMode {
                    $0.disabled = true
                }
            }
            <<< TextRow(){ row in
                row.title = Constants.TeacherFormKeys.NameRowTitle
                row.placeholder = Constants.TeacherFormKeys.NamePlaceholder
                row.tag = Constants.TeacherFormKeys.NameTag
                row.value = editingTeacher?.name
            }
            <<< IntRow(){
                $0.title = Constants.TeacherFormKeys.AgeRowTitle
                $0.placeholder = Constants.TeacherFormKeys.AgePlaceholder
                $0.tag = Constants.TeacherFormKeys.AgeTag
                if isEditMode {
                    $0.value = Int(editingTeacher!.age)
                }
            }
            +++ Section(Constants.TeacherFormKeys.SectionOtherDetails)
            <<< DecimalRow(){
                $0.title = Constants.TeacherFormKeys.SalaryTitle
                $0.placeholder = Constants.TeacherFormKeys.SalaryPlaceholder
                $0.tag = Constants.TeacherFormKeys.SalaryTag
                if isEditMode {
                    $0.value = Double(editingTeacher!.salary)
                }
            }
            <<< TextRow(){
                $0.title = Constants.TeacherFormKeys.SubjectTitle
                $0.placeholder = Constants.TeacherFormKeys.SubjectPlaceholder
                $0.tag = Constants.TeacherFormKeys.SubjectTag
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

    // Tuple to reuse
    typealias TeacherdetailsType = (nationalID:String,name:String,age:Int16,salary:Float,subject:String)

    private func getTeacherDetails() -> (TeacherdetailsType)? {
        let idRow:TextRow? = form.rowBy(tag: Constants.TeacherFormKeys.IdNumberTag)
        let nameRow:TextRow? = form.rowBy(tag: Constants.TeacherFormKeys.NameTag)
        let ageRow:IntRow? = form.rowBy(tag: Constants.TeacherFormKeys.AgeTag)
        let salaryRow:DecimalRow? = form.rowBy(tag: Constants.TeacherFormKeys.SalaryTag)
        let subjectRow:TextRow? = form.rowBy(tag: Constants.TeacherFormKeys.SubjectTag)
        let errorTitle = Constants.ErrorMessages.MissingInfoErrorTitle

        guard let id = idRow?.value else {
            presentAlertWithTitle(title: errorTitle, message: Constants.ErrorMessages.NoIdError)
            return nil
        }
        guard let name = nameRow?.value else {
            presentAlertWithTitle(title: errorTitle, message: Constants.ErrorMessages.NoNameError)
            return nil
        }
        guard let age = ageRow?.value else {
            presentAlertWithTitle(title: errorTitle, message: Constants.ErrorMessages.NoAgeError)
            return nil
        }
        guard let salary = salaryRow?.value else {
            presentAlertWithTitle(title: errorTitle, message: Constants.ErrorMessages.NoSalaryError)
            return nil
        }
        guard let subject = subjectRow?.value else {
            presentAlertWithTitle(title: errorTitle, message: Constants.ErrorMessages.NoSubjectError)
            return nil
        }
        return (id,name,Int16(age) ,Float(salary),subject)
    }

    private func createTeacher(teacherDetails:TeacherdetailsType) {
        let manager = PeoplePersistenceManager()
        do {
            try manager.createTeacher(nationalID: teacherDetails.nationalID, name: teacherDetails.name, age: teacherDetails.age, salary: teacherDetails.salary, subject: teacherDetails.subject)
            manager.saveContext()
        } catch PersonError.idAlreadyExist {
            self.presentAlertWithTitle(title: Constants.ErrorMessages.UserExistsError, message: Constants.ErrorMessages.UserExistsErrorMessage)
        } catch {
            self.presentAlertWithTitle(title: Constants.ErrorMessages.UnknownError, message: Constants.ErrorMessages.UserCreationFailedError)
        }
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
