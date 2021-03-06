//
//  PopupTableView.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/24/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class PopupTableView: UIView {

    // The title label
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // The table view
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Add views
        addSubview(titleLabel)
        addSubview(tableView)
        
        // Setup constraints
        heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        var constraints = [NSLayoutConstraint]()
        let views: [String: UIView] = ["titleLabel": titleLabel, "tableView": tableView]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]-30-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel(50)][tableView]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
    }
}


