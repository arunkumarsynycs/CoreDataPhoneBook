//
//  CustomTableViewCell.swift
//  CoreDataPhoneBook
//
//  Created by Chintalapudi Vinod on 6/29/18.
//  Copyright © 2018 brn. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var titles: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
