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
        label.text = "What do you want to cook today?"
        label.textColor = .black
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: self.view.frame.midY-40, width: self.view.frame.width, height: 20)
        self.view.addSubview(label)
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).cgColor
        textField.layer.borderWidth = 2.0
        textField.textColor = .black
        textField.frame = CGRect(x: 20, y: label.frame.maxY + 10, width: self.view.frame.width - 40, height: 30)
        self.view.addSubview(textField)
        
        button.setTitle("Find Me Recipies", for: .normal)
        button.backgroundColor = .blue
        button.frame = CGRect(x: 20, y: textField.frame.maxY + 10, width: self.view.frame.width - 40, height: 30)
        button.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipes), for: .touchUpInside)
        self.view.addSubview(button)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchForRecipes() {
        self.navigationController!.pushViewController(RecipeViewController(ingredients: textField.text ?? ""), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }


}

