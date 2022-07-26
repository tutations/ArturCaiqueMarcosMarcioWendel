//
//  ProblemTableViewController.swift
//  ArturCaiqueMarcosMarcioWendel
//
//  Created by Artur Clemente on 25/07/22.
//

import UIKit
import CoreData

class ProblemListingTableViewController: UITableViewController {
    
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Sem problemas cadastrados"
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        return label
    }()

    lazy var fetchedResultController: NSFetchedResultsController<Problem> = {
        let fetchRequest: NSFetchRequest<Problem> = Problem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ProblemViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        
        vc.problem = fetchedResultController.object(at: indexPath)
    }
    
    private func loadProblems() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProblemTableViewCell else {
            return UITableViewCell()
        }
        
        let problem = fetchedResultController.object(at: indexPath)
        cell.configure(with: problem)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let problem = fetchedResultController.object(at: indexPath)
            context.delete(problem)
            try? context.save()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProblemListingTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
