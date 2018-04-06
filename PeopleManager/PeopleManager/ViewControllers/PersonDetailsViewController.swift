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

    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        if person != nil {
            self.nameLabel.text = person?.name ?? "n/a"
            self.idLabel.text = "ID: \(person?.nationalIdentityNo ?? "n/a")"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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