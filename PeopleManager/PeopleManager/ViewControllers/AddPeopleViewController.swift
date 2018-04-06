//
//  AddPeopleViewController.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/5/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import Eureka

class AddPeopleViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ppm = PeoplePersistenceManager()
        ppm.insertStudent(nationalID: "2222", name: "new student", age: 12, year: 2222)
        ppm.saveContext()
        configureForm()
    }

    private func configureForm() {
        form +++ Section("Person Info")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Number"
                $0.placeholder = "And phone number here"
            }
            +++ Section("Other")
            <<< DateRow(){
                $0.title = "Birthday"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
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
