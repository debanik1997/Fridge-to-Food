//
//  RecipeSearchViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Firebase
import UIKit
import FirebaseFirestore

class RecipeSearchViewController: UIViewController {
    let label = UILabel()
    let textField = UITextField()
    let recipeButton = UIButton(type: .roundedRect)
    let fridgeButton = UIButton(type: .roundedRect)
    var fridgeRef: DocumentReference!
    
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
        
        recipeButton.setTitle("Find Me Recipies", for: .normal)
        recipeButton.backgroundColor = .blue
        recipeButton.frame = CGRect(x: 20, y: textField.frame.maxY + 10, width: self.view.frame.width - 40, height: 50)
        recipeButton.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipes), for: .touchUpInside)
        self.view.addSubview(recipeButton)
        
        fridgeButton.setTitle("Search From Fridge", for: .normal)
        fridgeButton.backgroundColor = .blue
        fridgeButton.frame = CGRect(x: 20, y: textField.frame.maxY + 70, width: self.view.frame.width - 40, height: 50)
        fridgeButton.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipesFromFridge), for: .touchUpInside)
        self.view.addSubview(fridgeButton)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchForRecipes() {
        textField.resignFirstResponder()
        self.navigationController!.pushViewController(RecipeViewController(ingredients: textField.text ?? ""), animated: true)
    }
   
    @objc func searchForRecipesFromFridge() {
        textField.resignFirstResponder()
        self.fridgeRef.collection("ingredients").getDocuments() {
            (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var ingredientString = String()
                    for document in querySnapshot!.documents {
                        ingredientString = "\(ingredientString)\(document.data()["name"] ?? ""), "
                    }
                    self.navigationController!.pushViewController(RecipeViewController(ingredients: ingredientString), animated: true)
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.fridgeRef = Firestore.firestore().collection("fridges").document("1")
    }


}

