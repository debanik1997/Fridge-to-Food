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
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
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
