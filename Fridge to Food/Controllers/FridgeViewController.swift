//
//  FridgeViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class FridgeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )
    var fridge: Fridge?
    
    init() {
        fridge?.carbs = [
            Ingredient(name: "bread"),
            Ingredient(name: "rice"),
        ]
        fridge?.proteins = [
            Ingredient(name: "chicken"),
            Ingredient(name: "beef"),
            Ingredient(name: "lamb")
        ]
//        fridge?.dairy = []
//        fridge?.produce = []
//        fridge?.fatsAndSugars = []
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fridge"
        collectionView?.backgroundColor = .white
        collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: "ingredientCell")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
//        if (section == 0) {
//            return fridge!.carbs!.count
//        } else {
//            return fridge!.proteins!.count
//        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}
