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
        label.textColor = UIColor(hexString: "664147")
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
        recipeButton.setTitleColor(UIColor(hexString: "664147"), for: .normal)
        recipeButton.backgroundColor = UIColor(hexString: "2F9C95")
        recipeButton.frame = CGRect(x: 20, y: textField.frame.maxY + 10, width: self.view.frame.width - 40, height: 50)
        recipeButton.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipes), for: .touchUpInside)
        self.view.addSubview(recipeButton)
        
        fridgeButton.setTitle("What's In My Fridge?", for: .normal)
        fridgeButton.setTitleColor(UIColor(hexString: "664147"), for: .normal)
        fridgeButton.backgroundColor = UIColor(hexString: "2F9C95")
        fridgeButton.frame = CGRect(x: 20, y: textField.frame.maxY + 70, width: self.view.frame.width - 40, height: 50)
        fridgeButton.addTarget(self, action: #selector(RecipeSearchViewController.searchForRecipesFromFridge), for: .touchUpInside)
        self.view.addSubview(fridgeButton)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchForRecipes() {
        textField.resignFirstResponder()
        self.fetch_recipes(ingredients: textField.text ?? "") { (recipes) in
            DispatchQueue.main.async {
                self.navigationController!.pushViewController(RecipeViewController(recipes: recipes), animated: true)
            }
        }
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
                    self.fetch_recipes(ingredients: ingredientString) { (recipes) in
                        DispatchQueue.main.async {
                            self.navigationController!.pushViewController(RecipeViewController(recipes: recipes), animated: true)
                        }
                    }
                }
            }
    }
    
    func fetch_recipes(ingredients: String, callback: @escaping ([Recipe]) -> Void) {
        let spoonacularRecipeClient = SpoonacularRecipeClient(apiKey: "488ea7c92d34469191c8296b57480d69")
        spoonacularRecipeClient.send(SearchRecipesByIngredients(ingredients: ingredients, number: 10, ranking: 1)) { response in
            switch response {
            case .success(let dataContainer):
                var recipes = [Recipe]()
                for recipe in dataContainer.results {
                    recipes.append(recipe)
                }
                callback(recipes)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(hexString: "E5F9E0")
        self.fridgeRef = Firestore.firestore().collection("fridges").document("1")
    }


}

