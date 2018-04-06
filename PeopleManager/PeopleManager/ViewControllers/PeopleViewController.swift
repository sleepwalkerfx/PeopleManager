//
//  PeopleTableViewController.swift
//  PeopleManager
//
//  Created by Rukshan Marapana on 4/4/18.
//  Copyright © 2018 Rukshan Marapana. All rights reserved.
//

import UIKit
import CoreData

class PeopleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchResultController: NSFetchedResultsController<Student>?
    var peoplePersistenceManager: PeoplePersistenceManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.peoplePersistenceManager = PeoplePersistenceManager()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func refreshScreen() {
        if let persistenceManager = self.peoplePersistenceManager {
            let request: NSFetchRequest<Student> = Student.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name",ascending:true)]
           // request.predicate
            fetchResultController = NSFetchedResultsController<Student>(fetchRequest: request, managedObjectContext: persistenceManager.persistenceContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        }
        try? fetchResultController?.performFetch()
        tableView.reloadData()
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

// MARK: - UITableViewDataSource
extension PeopleViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController?.sections {
           return sections[section].numberOfObjects
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        if let person = fetchResultController?.object(at: indexPath)
        {
            cell.textLabel?.text = person.name
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PeopleViewController: UITableViewDelegate {
}
