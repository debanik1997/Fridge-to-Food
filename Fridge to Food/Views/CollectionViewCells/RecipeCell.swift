//
//  RecipeCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/12/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Cosmos

class RecipeCell: BaseCell {
    
    var btnTapAction : (()->())?
    
    var navigationController: UINavigationController?
    
    var recipe: Recipe? {
        didSet {
            // Set views based on recipe
            recipeTitleLabel.text = recipe?.title
            starRating.rating = getRating(likes: recipe?.likes)
            setupRecipeImage()
        }
    }
    
    func getRating(likes: Int?) -> Double {
        if let likeCount = likes {
            let rating = 5 * Double(likeCount) / 300
            return rating
        } else {
            return 0
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
        title.font = UIFont(name: "verdana", size: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let missingIngredientsButton : UIButton = {
        var button = UIButton()
        button.setTitle("Missing Ingredients", for: .normal)
        button.titleLabel?.font = UIFont(name: "verdana", size: 14)
        button.backgroundColor = UIColor(hexString: "2F9C95")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let usedIngredientsButton : UIButton = {
        var button = UIButton()
        button.setTitle("Used Ingredients", for: .normal)
        button.titleLabel?.font = UIFont(name: "verdana", size: 14)
        button.backgroundColor = UIColor(hexString: "2F9C95")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let starRating : CosmosView = {
        var cosmosView = CosmosView()
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.filledColor = UIColor(hexString: "2F9C95")
        cosmosView.settings.emptyBorderColor = UIColor(hexString: "2F9C95")
        cosmosView.settings.filledBorderColor = UIColor(hexString: "2F9C95")
        cosmosView.settings.fillMode = .precise
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        return cosmosView
    }()
    
    let noRatingLabel: UILabel = {
        let title = UILabel()
        title.text = "No Rating"
        title.textColor = .black
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = UIFont(name: "verdana", size: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let cookMeButton : UIButton = {
        var button = UIButton()
        button.setTitle("Cook Me!", for: .normal)
        button.titleLabel?.font = UIFont(name: "verdana", size: 14)
        button.backgroundColor = UIColor(hexString: "2F9C95")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        let recipeImageConstraints = [
            recipeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 26),
            recipeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -1*self.frame.width/4),
            recipeImageView.widthAnchor.constraint(equalToConstant: 161),
            recipeImageView.heightAnchor.constraint(equalToConstant: 143)
        ]
        NSLayoutConstraint.activate(recipeImageConstraints)
        
        if (starRating.rating > 1) {
            addSubview(starRating)
            let starRatingConstraints = [
                starRating.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 10),
                starRating.centerXAnchor.constraint(equalTo: recipeImageView.centerXAnchor, constant: -1*starRating.frame.width/2),
                starRating.widthAnchor.constraint(equalToConstant: recipeImageView.frame.width),
                starRating.heightAnchor.constraint(equalToConstant: 24)
            ]
             NSLayoutConstraint.activate(starRatingConstraints)
        }
        
        addSubview(separatorView)
        let separatorViewConstraints = [
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.widthAnchor.constraint(equalTo: self.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(separatorViewConstraints)
        
        addSubview(recipeTitleLabel)
        let recipeTitleLabelConstraints = [
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            recipeTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width/4),
            recipeTitleLabel.widthAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            recipeTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(recipeTitleLabelConstraints)
        
        addSubview(missingIngredientsButton)
        let missingIngredientsButtonConstraints = [
            missingIngredientsButton.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 10),
            missingIngredientsButton.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            missingIngredientsButton.widthAnchor.constraint(equalTo: recipeTitleLabel.widthAnchor),
            missingIngredientsButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        NSLayoutConstraint.activate(missingIngredientsButtonConstraints)
        
        addSubview(usedIngredientsButton)
        let usedIngredientsButtonConstraints = [
            usedIngredientsButton.topAnchor.constraint(equalTo: missingIngredientsButton.bottomAnchor, constant: 10),
            usedIngredientsButton.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            usedIngredientsButton.widthAnchor.constraint(equalTo: missingIngredientsButton.widthAnchor),
            usedIngredientsButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        NSLayoutConstraint.activate(usedIngredientsButtonConstraints)
        
        addSubview(cookMeButton)
        let cookMeButtonConstraints = [
            cookMeButton.topAnchor.constraint(equalTo: usedIngredientsButton.bottomAnchor, constant: 10),
            cookMeButton.centerXAnchor.constraint(equalTo: recipeTitleLabel.centerXAnchor),
            cookMeButton.widthAnchor.constraint(equalTo: missingIngredientsButton.widthAnchor),
            cookMeButton.heightAnchor.constraint(equalToConstant: 55)
        ]
        NSLayoutConstraint.activate(cookMeButtonConstraints)
        
        cookMeButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
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
