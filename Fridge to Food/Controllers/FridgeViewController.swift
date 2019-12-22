//
//  FridgeViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController {
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )
    private let foodGroups = ["Grains", "Meat/Fish", "Dairy", "Produce", "Fats/Sugar", "Misc."]
    weak var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.frame = CGRect(x: self.view.frame.midX-100, y: self.view.frame.minY + 150, width: 200, height: 200)
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        let nameLabel = UILabel()
        nameLabel.text = "Debanik Purkayastha"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 5, width: self.view.frame.width, height: 30)
        nameLabel.font = UIFont(name: "verdana", size: 25.0)
        self.view.addSubview(nameLabel)
        
        let fridgeLabel = UILabel()
        fridgeLabel.text = "Your Fridge"
        fridgeLabel.textColor = .black
        fridgeLabel.textAlignment = .center
        fridgeLabel.frame = CGRect(x: 0, y: self.view.frame.midY, width: self.view.frame.width, height: 30)
        fridgeLabel.font = UIFont(name: "verdana", size: 25.0)
        self.view.addSubview(fridgeLabel)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: fridgeLabel.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.collectionView = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView?.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
        collectionView.register(FoodGroupCell.self, forCellWithReuseIdentifier: "ingredientCell")
    }
}
    
extension FridgeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath) as! FoodGroupCell
        cell.foodGroup = foodGroups[indexPath.row]
        return cell
    }
}

extension FridgeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

extension FridgeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
        return CGSize(width: widthPerItem, height: widthPerItem*1.2)
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
