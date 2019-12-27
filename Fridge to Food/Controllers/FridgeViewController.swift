//
//  FridgeViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import PopupDialog
import Firebase
import FirebaseFirestore
import FaceAware

class FridgeViewController: UIViewController {
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )
    weak var collectionView: UICollectionView!
    var fridgeRef: DocumentReference!
    
    private let foodGroups = ["Grains", "Meat", "Dairy", "Produce", "Fats", "Misc."]
    private var fridge: Fridge?
    
    override func loadView() {
        super.loadView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Debanik")
        imageView.focusOnFaces = true
        imageView.frame = CGRect(x: self.view.frame.midX-100, y: self.view.frame.minY + 150, width: 200, height: 200)
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(hexString: "2F9C95").cgColor
        imageView.layer.borderWidth = 5.5;
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 1.0
        imageView.didFocusOnFaces = {
             self.view.addSubview(imageView)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = "Debanik Purkayastha"
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 5, width: self.view.frame.width, height: 40)
        nameLabel.font = UIFont(name: "Noteworthy-Light", size: 25.0)
        self.view.addSubview(nameLabel)
        
        let fridgeLabel = UILabel()
        fridgeLabel.text = "Your Fridge"
        fridgeLabel.textColor = .black
        fridgeLabel.textAlignment = .center
        fridgeLabel.frame = CGRect(x: 0, y: self.view.frame.midY, width: self.view.frame.width, height: 40)
        fridgeLabel.font = UIFont(name: "Noteworthy-Light", size: 25.0)
        self.view.addSubview(fridgeLabel)
        
        let addButton = UIButton()
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = UIColor(hexString: "2F9C95")
        addButton.frame = CGRect(x: 4.5*self.view.frame.width / 6, y: self.view.frame.midY, width: self.view.frame.width/6, height: 40)
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
         addButton.addTarget(self, action: #selector(FridgeViewController.showIngredientPopup), for: .touchUpInside)
        self.view.addSubview(addButton)
        
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
        self.fridgeRef = Firestore.firestore().collection("fridges").document("1")
        self.getFridge(fridgeDocRef: self.fridgeRef)
        self.view.backgroundColor = UIColor(hexString: "E5F9E0")
        self.collectionView?.backgroundColor = UIColor(hexString: "E5F9E0")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
        collectionView.register(FoodGroupCell.self, forCellWithReuseIdentifier: "ingredientCell")
    }
    
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
                        let ingredient = try! JSONDecoder().decode(Ingredient.self, from: json)
                        testFridge.addIngredient(ingredient: ingredient)
                    }
                }
                self.fridge = testFridge
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    @objc func showIngredientPopup() {
        let ingredientPopupVC = IngredientPopupViewController(nibName: nil, bundle: nil)
        let popup = PopupDialog(
            viewController: ingredientPopupVC,
            buttonAlignment: .horizontal,
            tapGestureDismissal: false) {
        }
        let cancel = DefaultButton(title: "Cancel") {
            print("User did not select a food group")
        }
        let add = DefaultButton(title: "Add") {
            guard let foodGroup = ingredientPopupVC.getFoodGroup() else { return }
            guard let ingredientName = ingredientPopupVC.getIngredient() else { return }
            if (foodGroup != "" && ingredientName != "") {
                self.addToFridge(ingredientName: ingredientName, foodGroup: foodGroup, fridgeID: "1")
            }
        }
        ingredientPopupVC.foodGroups = self.foodGroups
        popup.addButton(cancel)
        popup.addButton(add)
        ingredientPopupVC.popup = popup
        self.present(popup, animated: true, completion: nil)
    }
    
    func addToFridge(ingredientName: String, foodGroup: String, fridgeID: String) {
        fridgeRef.collection("ingredients").addDocument(data: [
            "name": ingredientName,
            "group": foodGroup
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                let index = self.foodGroups.lastIndex(of: foodGroup)
                let idxPath = IndexPath(item: index!, section: 0)
                self.fridge?.addIngredient(ingredient: Ingredient(name: ingredientName, group: foodGroup))
                DispatchQueue.main.async {
                    self.collectionView?.reloadItems(at: [idxPath])
                }
            }
        }
    }
    
    func getIngredientsOfFoodGroup(foodGroup: String) -> [Ingredient] {
        return self.fridge?.ingredients.filter{$0.group == foodGroup} ?? [Ingredient]()
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
        cell.foodGroup = self.foodGroups[indexPath.row]
        cell.ingredients = self.getIngredientsOfFoodGroup(foodGroup: self.foodGroups[indexPath.row])
        return cell
    }
}

extension FridgeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        fridgeRef.collection("ingredients").whereField("group", isEqualTo: self.foodGroups[indexPath.row])
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var ingredients = [String]()
                    for document in querySnapshot!.documents {
                        ingredients.append(document.data()["name"] as! String)
                    }
                    let vc = PopupTableViewController(nibName: nil, bundle: nil)
                    let popup = PopupDialog(viewController: vc, transitionStyle: .zoomIn, tapGestureDismissal: false) {
                        guard let ingredient = vc.selectedIngredient else { return }
                        print("User selected ingredient: \(ingredient)")
                    }
                    let cancel = DefaultButton(title: "Cancel") {
                        print("User did not select an ingredient")
                    }
                    popup.addButton(cancel)
                    vc.name = self.foodGroups[indexPath.row]
                    vc.ingredients = ingredients
                    vc.popup = popup
                    self.present(popup, animated: true, completion: nil)
                }
        }
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
