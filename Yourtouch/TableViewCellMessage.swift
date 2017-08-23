//
//  TableViewCellMessage.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit

class TableViewCellMessage: UITableViewCell {

    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var viewBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
