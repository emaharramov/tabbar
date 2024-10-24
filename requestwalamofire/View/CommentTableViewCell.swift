//
//  CommentTableViewCell.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet private weak var bodyField: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: CommentStruct) {
        titleLabel?.text = model.name
        emailLabel?.text = model.email
        bodyField?.text = model.body
    }
}
