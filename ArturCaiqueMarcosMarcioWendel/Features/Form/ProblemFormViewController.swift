//
//  ProblemFormViewController.swift
//  ArturCaiqueMarcosMarcioWendel
//
//  Created by Artur Clemente on 25/07/22.
//

import UIKit

class ProblemFormViewController: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var datePickerProblem: UIDatePicker!
    @IBOutlet weak var buttonSave: UIButton!
    
    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerProblem.maximumDate = Date()
        if let problem = problem {
            textFieldTitle.text = problem.title
            textFieldAddress.text = problem.address
            textViewSummary.text = problem.summary
            datePickerProblem.date = problem.date ?? Date()
            title = "Edição do Problema"
            buttonSave.setTitle("Atualizar Problema", for: .normal)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if problem == nil {
            problem = Problem(context: context)
        }
        problem?.title = textFieldTitle.text
        problem?.address = textFieldAddress.text
        problem?.summary = textViewSummary.text
        problem?.date = datePickerProblem.date
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
}
