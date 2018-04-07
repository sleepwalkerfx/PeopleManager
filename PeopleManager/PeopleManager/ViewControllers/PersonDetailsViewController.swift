//
//  PersonDetailsViewController.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/6/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var extraInfoFeild1: UILabel!
    @IBOutlet weak var extraInfoFeild2: UILabel!
    @IBOutlet weak var extraInfoField3: UILabel!
    
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    private func setupUI() {
        if person != nil {
            self.nameLabel.text = "Name: \(String(describing: person!.name ?? "n/a"))"
            self.idLabel.text = "Id: \(person!.nationalIdentityNo ?? "n/a")"
            self.ageLabel.text = "Age: \(person!.age)"

            if person is Student {
                self.titleLabel.text = "STUDENT PROFILE"
                self.extraInfoFeild1.text = "Course Year: \((person as! Student).year)"
            }

            if person is Teacher {
                self.titleLabel.text = "TEACHER PROFILE"
                self.extraInfoFeild1.text = "Salary: \((person as! Teacher).salary)"
                self.extraInfoFeild2.text = "Subject: \((person as! Teacher).subject ?? "")"

            }
        }
    }
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        guard let addPeopleNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "AddPeopleNC") as? UINavigationController else {
            return
        }
        //        if let addpeopleVC = addPeopleNavigationController.viewControllers.first as? AddPeopleViewController {
        //            addpeopleVC.title = "Edit Person"
        //            addpeopleVC.editingPerson = self.person
        //            self.present(addPeopleNavigationController, animated: true, completion: nil)
        //        }

    }


}
