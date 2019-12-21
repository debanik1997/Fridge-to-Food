//
//  RecipeCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/12/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class RecipeCell: BaseCell {
    
    var btnTapAction : (()->())?
    
    var navigationController: UINavigationController?
    
    var recipe: Recipe? {
        didSet {
            // Set views based on recipe
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
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
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
        var button = UIButton()
        button.setTitle("Cook Me!", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let missingIngredientCountLabel : UILabel = {
        let title = UILabel()
        title.text = ""
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        addSubview(separatorView)
        addSubview(recipeTitleLabel)
        addSubview(cookMeButton)
        addSubview(missingIngredientCountLabel)
        cookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        // Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: recipeImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: recipeTitleLabel)
        addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: cookMeButton)
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: missingIngredientCountLabel)
        
        // Vertical Constraints
        addConstraintsWithFormat(format: "V:|-40-[v0]-15-[v1(75)]-15-[v2(35)]-15-[v3(25)]-120-[v4(1)]|", views: recipeImageView, recipeTitleLabel, cookMeButton, missingIngredientCountLabel, separatorView)
    }
    
    @objc func buttonClicked(sender : UIButton){
        if let recipes = recipe?.title{
            let alert = UIAlertController(title: "Are you hungry?", message: "Would you like to make \(recipes)?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Yes", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            btnTapAction?()
        }
    }
}
