//
//  TitleImageTableViewCell.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit


final class TitleImageTableViewCell: UITableViewCell {
    
    
    // MARK:- IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var astroImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:- Custom Methods
    
    func configure(text: String?, image: UIImage) {
        titleLabel.text = text
        astroImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
