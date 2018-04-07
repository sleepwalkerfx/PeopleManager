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
        setupUI()
        self.peoplePersistenceManager = PeoplePersistenceManager()
        refreshScreen()
        self.fetchResultController?.delegate = self
    }

    private func setupUI(){
        // self.navigationItem.rightBarButtonItem =
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func refreshScreen() {
        if let persistenceManager = self.peoplePersistenceManager {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name",ascending:true)]
            fetchResultController = NSFetchedResultsController<Person>(fetchRequest: request, managedObjectContext: persistenceManager.persistenceContainer.viewContext, sectionNameKeyPath: "groupType", cacheName: nil)
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
            print("sections count \(sections.count)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
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
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            self.tableArray.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = fetchResultController?.object(at: indexPath)
            Person.remove(person: personToDelete!, from: (self.peoplePersistenceManager?.persistenceContainer.viewContext)!)
            self.peoplePersistenceManager?.saveContext()
        }
    }
}

extension PeopleViewController:NSFetchedResultsControllerDelegate {

    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections([sectionIndex], with: .fade)
        case .delete: tableView.deleteSections([sectionIndex], with: .fade)
        default: break
        }
    }
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }

    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}
