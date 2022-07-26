//
//  ProblemTableViewCell.swift
//  ArturCaiqueMarcosMarcioWendel
//
//  Created by Artur Clemente on 26/07/22.
//

import UIKit

class ProblemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLabelTitle: UILabel!
    @IBOutlet weak var textLabelDate: UILabel!
    
    func configure(with problem: Problem) {
        textLabelTitle.text = problem.title
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textLabelDate.text = formatter.string(from: problem.date ?? Date())
    }
}
