//
//  CustomTableViewCell.swift
//  Game of Thrones
//
//  Created by Macho Man on 7/1/18.
//  Copyright © 2018 siddharth. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
@IBOutlet weak var Label: UILabel!
@IBOutlet weak var ImageView: UIImageView!
    
override func awakeFromNib() {
// UI Design for Outlets
ImageView.layer.cornerRadius = 50.0
ImageView.layer.borderColor = UIColor.white.cgColor
ImageView.layer.borderWidth = 3.0
ImageView.clipsToBounds = false
ImageView.layer.masksToBounds = true
super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
