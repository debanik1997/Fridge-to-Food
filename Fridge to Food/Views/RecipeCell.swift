//
//  RecipeCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/12/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Foundation

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

class RecipeCell: BaseCell {
    
    var recipe: Recipe? {
        didSet {
            recipeTitleLabel.text = recipe?.title
            setupRecipeImage()
        }
    }
    
    func setupRecipeImage() {
        if let recipeImageUrl = recipe?.image {
            let resourceURL = URL(string: recipeImageUrl)
            URLSession.shared.dataTask(with: resourceURL!) {data, response, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                DispatchQueue.main.async {
                    self.recipeImageView.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recipeTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Shrimp Scampi"
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let recipeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cookMeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cook Me!", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        addSubview(separatorView)
        addSubview(recipeTitleLabel)
        addSubview(cookMeButton)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: recipeImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: recipeTitleLabel)
        addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: cookMeButton)
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-40-[v0]-15-[v1(25)]-15-[v2(35)]-160-[v3(1)]|", views: recipeImageView, recipeTitleLabel, cookMeButton, separatorView)
    }
}
