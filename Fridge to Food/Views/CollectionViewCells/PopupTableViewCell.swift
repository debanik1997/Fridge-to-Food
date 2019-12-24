//
//  PopupTableViewCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/24/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class PopupTableViewCell: UITableViewCell {

    /// The reuse identifier for this cell
    static let cellIdentifier = "PopupTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

}
