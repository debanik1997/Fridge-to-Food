//
//  ComplexRecipeSearchViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Eureka
import FirebaseFirestore

class ComplexRecipeSearchViewController: FormViewController {
    var ingredients = [Ingredient]()
    var diets = [Diet]()
    private var fridge: Fridge?
    var fridgeRef: DocumentReference!
    
    // Duplicate Code
    func getFridge(fridgeDocRef: DocumentReference) {
        fridgeDocRef.collection("ingredients").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let testFridge = Fridge()
                for document in querySnapshot!.documents {
                    let result = document.data()
                    let jsonData = try? JSONSerialization.data(withJSONObject:result)
                    if let json = jsonData {
                        var ingredient = try! JSONDecoder().decode(Ingredient.self, from: json)
                        ingredient.group = self.getGroupFromAisle(aisle: ingredient.aisle)
                        testFridge.addIngredient(ingredient: ingredient)
                    }
                }
                self.fridge = testFridge
                DispatchQueue.main.async {
                    if let row = self.form.rowBy(tag: "Ingredients") as? MultipleSelectorRow<Ingredient> {
                        row.options = self.fridge?.ingredients
                        row.updateCell()
                    }
                }
            }
        }
    }
    
    // Duplicate Code
    func getGroupFromAisle(aisle: String) -> String {
        switch aisle {
        case let str where str.contains("Pasta and Rice") || str.contains("Bakery/Bread") || str.contains("Bread"):
            return "Grains"
        case let str where str.contains("Meat") || str.contains("Seafood"):
            return "Meat"
        case let str where str.contains("Milk, Eggs, Other Dairy") || str.contains("Cheese"):
            return "Dairy"
        case let str where str.contains("Produce") || str.contains("Dried Fruits"):
            return "Produce"
        case let str where str.contains("Oil, Vinegar, Salad Dressing"):
            return "Fats"
        default:
            return "Misc."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fridgeRef = Firestore.firestore().collection("fridges").document("1")
        self.getFridge(fridgeDocRef: self.fridgeRef)
        ingredients.append(Ingredient(id: 10, name: "Chicken", aisle: "Meat", group: "Meat"))
        ingredients.append(Ingredient(id: 12, name: "Broccoli", aisle: "Produce", group: "Produce"))
        diets.append(Diet.None)
        diets.append(Diet.Vegetarian)
        diets.append (Diet.Paleo)
        
        form +++
            Section()
            <<< TextRow("Query") {
                $0.title = "Search Query"
                $0.placeholder = "What are you looking to make?"
            }
            <<< MultipleSelectorRow<Ingredient>("Ingredients") {
                $0.title = "Choose Your Ingredients"
                $0.options = self.fridge?.ingredients
                }
                .onPresent { from, to in
                    to.sectionKeyForValue = { option in
                        return option.group ?? "Misc."
                    }
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(ComplexRecipeSearchViewController.multipleSelectorDone(_:)))
            }
            
            +++ Section("Choose Your Diet")
            
            <<< SegmentedRow<Diet>("Diet"){
                $0.options = diets
                $0.value = Diet.None
                $0.displayValueFor = {
                    return $0.map { $0.rawValue  }
                }
            }
            
            +++ Section()
            
            <<< ButtonRow() {
                $0.title = "Find me recipes!"
            }
            .onCellSelection {_,_ in
                self.getRecipes(form: self.form.values())
            }
    }
    
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func getRecipes(form: [String:Any?]) {
        let spoonacularRecipeClient = SpoonacularRecipeClient(apiKey: "488ea7c92d34469191c8296b57480d69")
        let query = form["Query"] as? String
        let ingredients = (form["Ingredients"] as? Set<Ingredient>) ?? Set<Ingredient>()
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString = "\(ingredientString)\(ingredient.name), "
        }
        let diet = form["Diet"] as! Diet
        var dietString = "\(diet)"
        if (diet == Diet.None) {
            dietString = ""
        }
        spoonacularRecipeClient.send(SearchRecipesComplex(query: query, diet: dietString, includeIngredients: ingredientString, number: 2)) { response in
            switch response {
            case .success(let dataContainer):
                DispatchQueue.main.async {
                    self.navigationController!.pushViewController(RecipeViewController(recipes: dataContainer.results.results!), animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
