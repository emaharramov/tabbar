//
//  CollectionViewCell.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: PostStruct) {
        titleLabel.text = model.title
        descriptionField.text = model.body
    }

}
