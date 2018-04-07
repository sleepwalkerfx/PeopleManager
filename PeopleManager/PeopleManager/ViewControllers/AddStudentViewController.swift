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

    var editingPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
        configureUI()
    }

    private func configureUI() {
        if editingPerson != nil {
            let nameRow:TextRow? = form.rowBy(tag: "personName")
            nameRow?.value = editingPerson?.name!

            let idRow:TextRow? = form.rowBy(tag: "id")
            idRow?.value = editingPerson?.nationalIdentityNo!

            let ageRow:IntRow? = form.rowBy(tag: "age")
            // ageRow?.value = editingPerson?.age as! Int
        }
    }

    private func configureForm() {
        form +++ Section("Person Info")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
                row.tag = "personName"
            }
            <<< TextRow(){
                $0.title = "ID Number"
                $0.placeholder = "And ID number here"
                $0.tag = "id"
            }
            +++ Section("Other")
            <<< IntRow(){
                $0.title = "Age"
                $0.value = 0
                $0.tag = "age"
            }
            +++ Section(header: "Email Rule, Required Rule", footer: "Options: Validates on change after blurred")
            <<< TextRow() {
                $0.title = "Email Rule"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        print("done tapped")
        let nameRow:TextRow? = form.rowBy(tag: "personName")
        let idRow:TextRow? = form.rowBy(tag: "id")
        let ageRow:IntRow? = form.rowBy(tag: "age")
        guard let name = nameRow?.value else {
            print("no name given")
            return
        }
        guard let id = idRow?.value else {
            print("no id given")
            return
        }

        guard let group = ageRow?.value else {
            print("no group given")
            return
        }
        if group == 0 {
            if editingPerson != nil {
                editingPerson?.name = name
                editingPerson?.nationalIdentityNo = id
                try? AppDelegate.viewContext.save()
                self.dismiss(animated: true, completion: nil)

            }else {
                createStudent(nationalID: id, name: name, age: 18, year: 2019)
            }
        } else {
            if editingPerson != nil {
                editingPerson?.name = name
                editingPerson?.nationalIdentityNo = id
                try? AppDelegate.viewContext.save()
                self.dismiss(animated: true, completion: nil)

            } else {
                createTeacher(nationalID: id, name: name, age: 20, salary: 394.0, subject: "subject here")
            }
        }

    }

    private func createStudent(nationalID:String,name:String,age:Int16,year:Int16) {
        let manager = PeoplePersistenceManager()
        manager.createStudent(nationalID: nationalID, name: name, age: age, year: year)
        manager.saveContext()
        self.dismiss(animated: true, completion: nil)
    }

    private func createTeacher(nationalID:String,name:String,age:Int16,salary:Float,subject:String) {
        let manager = PeoplePersistenceManager()
        manager.createTeacher(nationalID: nationalID, name: name, age: age, salary: salary, subject: subject)
        manager.saveContext()
        self.dismiss(animated: true, completion: nil)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
