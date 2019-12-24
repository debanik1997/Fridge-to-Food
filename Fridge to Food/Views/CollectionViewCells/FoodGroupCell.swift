//
//  FoodGroupCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class FoodGroupCell : BaseCell {
    
    var foodGroup: String? {
        didSet {
//            foodGroupLabel.text = foodGroup
//            foodGroupLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Grains")!)
            foodGroupImage.image = UIImage(named: foodGroup!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodGroupLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    let foodGroupImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        addSubview(foodGroupImage)
        
        // Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: foodGroupImage)
        
        // Vertical Constraint
        addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: foodGroupImage)
        
    }
}
