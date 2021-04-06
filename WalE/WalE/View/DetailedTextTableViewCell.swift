//
//  DetailedTextTableViewCell.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class DetailedTextTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var detailLabel: UILabel!
    
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Custom Methods
    func configure(detailText: String?) {
        detailLabel.text = detailText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
