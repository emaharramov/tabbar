//
//  AlbumsTableViewCell.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet private weak var albumField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: AlbumStruct) {
        albumField?.text = model.title
    }
}
