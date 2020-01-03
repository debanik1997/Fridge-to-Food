//
//  ComplexRecipeSearchViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Eureka

class ComplexRecipeSearchViewController: FormViewController {
    var ingredients = [Ingredient]()
    var diets = [Diet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredients.append(Ingredient(id: 10, name: "Chicken", aisle: "Meat", group: "Meat"))
        ingredients.append(Ingredient(id: 12, name: "Brocolli", aisle: "Produce", group: "Produce"))
        diets.append(Diet.None)
        diets.append(Diet.Glutenfree)
        diets.append(Diet.Paleo)
        
        form +++
            Section()
            <<< TextRow("Query") {
                $0.title = "Search Query"
                $0.placeholder = "What are you looking to make?"
            }
            <<< MultipleSelectorRow<Ingredient>("Ingredients") {
                $0.title = "Choose Your Ingredients"
                $0.options = ingredients
                }
                .onPresent { from, to in
                    to.sectionKeyForValue = { option in
                        return option.group!
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
        spoonacularRecipeClient.send(SearchRecipesComplex(query: "Pasta", includeIngredients: "Chicken, Brocolli")) { response in
            switch response {
            case .success(let dataContainer):
                print(dataContainer.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
