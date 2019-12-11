//
//  RecipeSearchViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {
    let label = UILabel()
    let textField = UITextField()
    let button = UIButton(type: .roundedRect)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        label.text = "What would you like to eat today?"
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: self.view.frame.midY-40, width: self.view.frame.width, height: 20)
        self.view.addSubview(label)
        
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 20, y: label.frame.maxY + 10, width: self.view.frame.width - 40, height: 30)
        self.view.addSubview(textField)
        
        button.setTitle("Find Me Recipies", for: .normal)
        button.frame = CGRect(x: 20, y: textField.frame.maxY + 10, width: self.view.frame.width - 40, height: 30)
        button.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipes), for: .touchUpInside)
        self.view.addSubview(button)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchForRecipes() {
        let queryText = textField.text ?? ""
        let recipeRequest = RecipeRequest(ingredients: queryText)
        recipeRequest.getRecipes { result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let recipes):
                    print(recipes)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
    }


}

