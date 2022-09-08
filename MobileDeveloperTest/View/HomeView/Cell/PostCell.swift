//
//  PostCell.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit

class PostCell: UITableViewCell {

    // MARK: - Vars
    static let identifier = "PostCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(title: String, author: String, created_at: String) {
        titleLabel.text = title
        footerLabel.text = "\(author) - \(created_at)"
    }
    
}
