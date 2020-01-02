//
//  PopupTableViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/24/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import PopupDialog

final class PopupTableViewController: UIViewController {
    
    // MARK: Public
    
    /// The PopupDialog this view is contained in
    /// Note: this has to be weak, otherwise we end up
    /// creating a retain cycle!
    public weak var popup: PopupDialog?
    
    /// The city the user did choose
    public fileprivate(set) var selectedIngredient: String?
    
    /// A list of cities to display
    public var ingredients = [String]() {
        didSet { baseView.tableView.reloadData() }
    }
    
    public var name = String() {
        didSet { baseView.titleLabel.text = name }
    }
    
    // MARK: Private

    // We will use this instead to reference our
    // controllers view instead of `view`
    fileprivate var baseView: PopupTableView {
        return view as! PopupTableView
    }
    
    // MARK: View related
    
    // Replace the original controller view
    // with our dedicated view
    override func loadView() {
        view = PopupTableView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the dialog (custom) title
        baseView.titleLabel.text = "Ingredients"
        
        // Setup tableView
        baseView.tableView.register(PopupTableViewCell.self, forCellReuseIdentifier: PopupTableViewCell.cellIdentifier)
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
    }
}

// MARK: - TableView Data Source

extension PopupTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopupTableViewCell.cellIdentifier, for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

// MARK: - TableView Delegate

extension PopupTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIngredient = ingredients[indexPath.row]
        popup?.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            print("Deleting \(indexPath)")
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
