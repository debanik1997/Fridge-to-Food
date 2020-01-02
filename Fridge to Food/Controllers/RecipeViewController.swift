//
//  RecipeViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/11/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class RecipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var recipes: [Recipe]?
    var ingredients: String
    
    init(ingredients: String) {
        self.ingredients = ingredients
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        self.ingredients = ""
        super.init(coder: coder)
    }
    
    func fetch_recipes(ingredients: String) {
        let spoonacularRecipeClient = SpoonacularRecipeClient(apiKey: "488ea7c92d34469191c8296b57480d69")
        spoonacularRecipeClient.send(SearchRecipesByIngredients(ingredients: ingredients, number: 10, ranking: 1)) { response in
            switch response {
            case .success(let dataContainer):
                self.recipes = [Recipe]()
                
                for recipe in dataContainer.results {
                    self.recipes?.append(recipe)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        fetch_recipes(ingredients: ingredients)
        super.viewDidLoad()
        navigationItem.title = "Recipes"
        collectionView?.backgroundColor = UIColor(hexString: "E5F9E0")
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! RecipeCell
        cell.recipe = recipes?[indexPath.item]
        cell.navigationController = self.navigationController
        
        // set a "Callback Closure" in the cell
        cell.btnTapAction = {
            () in
            print("Edit tapped in cell", indexPath)
            // EDIT HERE
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
