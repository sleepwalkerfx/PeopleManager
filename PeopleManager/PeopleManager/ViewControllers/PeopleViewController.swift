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
    var fetchResultController: NSFetchedResultsController<Person>?
    var peoplePersistenceManager: PeoplePersistenceManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.peoplePersistenceManager = PeoplePersistenceManager()
        refreshScreen()
        self.fetchResultController?.delegate = self
    }

    // Populating the data for the first time
    private func refreshScreen() {
        if let persistenceManager = self.peoplePersistenceManager {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "nationalIdentityNo",ascending:true)]
            fetchResultController = NSFetchedResultsController<Person>(fetchRequest: request, managedObjectContext: persistenceManager.persistentContainer.viewContext, sectionNameKeyPath: "groupType", cacheName: nil)
        }
        try? fetchResultController?.performFetch()
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let personDetailsVC = segue.destination as? PersonDetailsViewController {
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            personDetailsVC.person = fetchResultController?.object(at: indexPath!)
        }
    }
}

// MARK: - UITableViewDataSource
extension PeopleViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchResultController?.sections {
            return sections.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController?.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath)
        if let person = fetchResultController?.object(at: indexPath)
        {
            cell.textLabel?.text = person.name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchResultController?.sections {
            let currentSection = sections[section]
            return currentSection.name
        }
        return nil
    }
}

// MARK: - UITableViewDelegate
extension PeopleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = fetchResultController?.object(at: indexPath)
            Person.remove(person: personToDelete!, from: (self.peoplePersistenceManager?.persistentContainer.viewContext)!)
            self.peoplePersistenceManager?.saveContext()
        }
    }
}

