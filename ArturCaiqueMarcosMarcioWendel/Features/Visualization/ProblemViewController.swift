//
//  ProblemViewController.swift
//  ArturCaiqueMarcosMarcioWendel
//
//  Created by Artur Clemente on 26/07/22.
//

import UIKit

class ProblemViewController: UIViewController {

    var problem: Problem?
    
    @IBOutlet weak var textLabelTitle: UILabel!
    @IBOutlet weak var textLabelAddress: UILabel!
    @IBOutlet weak var textLabelDate: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let problem = problem {
            textLabelTitle.text = problem.title
            textLabelAddress.text = problem.address
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            textLabelDate.text = formatter.string(from: problem.date ?? Date())
            textViewSummary.text = problem.summary
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ProblemFormViewController else { return }
        vc.problem = problem
    }
}
