//
//  BaseCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
