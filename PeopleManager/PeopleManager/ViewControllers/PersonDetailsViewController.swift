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
                self.titleLabel.text = Constants.StudentProfile.Title
                self.extraInfoFeild1.text = "Course Year: \((person as! Student).year)"
            }

            if person is Teacher {
                self.titleLabel.text = Constants.TeacherProfile.Title
                self.extraInfoFeild1.text = "Salary: \((person as! Teacher).salary)"
                self.extraInfoFeild2.text = "Subject: \((person as! Teacher).subject ?? "")"

            }
        }
    }
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        if person is Student {
            editStudent(student: person as! Student)
        } else if person is Teacher {
            editTeacher(teacher: person as! Teacher)
        }
    }

    private func editStudent(student:Student){
        guard let editStudentNavigationController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardId.EditStudentNavId) as? UINavigationController else {
            return
        }
        if let editStudentVC = editStudentNavigationController.viewControllers.first as? AddStudentViewController {
            editStudentVC.title = Constants.StudentProfile.EditTitle
            editStudentVC.editingStudent =  student
            self.present(editStudentNavigationController, animated: true, completion: nil)
        }
    }

    private func editTeacher(teacher:Teacher){
        guard let editTeacherNavigationController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardId.EditTeacherNavId) as? UINavigationController else {
            return
        }
        if let editTeacherVC = editTeacherNavigationController.viewControllers.first as? AddTeacherViewController {
            editTeacherVC.title = Constants.TeacherProfile.EditTitle
            editTeacherVC.editingTeacher = teacher
            self.present(editTeacherNavigationController, animated: true, completion: nil)
        }
    }


}
