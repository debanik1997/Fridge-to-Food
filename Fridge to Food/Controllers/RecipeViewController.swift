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
        let API_KEY = "488ea7c92d34469191c8296b57480d69"
        let resourceString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(API_KEY)&ingredients=\(ingredients)"
        let urlString = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let resourceURL = URL(string: urlString ?? "")
        URLSession.shared.dataTask(with: resourceURL!) {data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.recipes = [Recipe]()
                for dictionary in json as! [[String: AnyObject]] {
                    let recipe = Recipe()
                    recipe.title = dictionary["title"] as? String
                    recipe.id = dictionary["id"] as? Int
                    recipe.image = dictionary["image"] as? String
                    recipe.likes = dictionary["likes"] as? Int
                    self.recipes?.append(recipe)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonError{
                print(jsonError)
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        fetch_recipes(ingredients: ingredients)
        super.viewDidLoad()
        navigationItem.title = "Recipes"
        collectionView?.backgroundColor = .white
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
        return CGSize(width: view.frame.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
