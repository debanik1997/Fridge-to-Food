//
//  PickerView.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation
import UIKit
 
class PickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var pickerData : [String]!
    var pickerTextField : UITextField!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
 
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
 
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
 
        self.delegate = self
        self.dataSource = self
        
        if pickerData.count > 0 {
            self.pickerTextField.text = self.pickerData[0]
            self.pickerTextField.isEnabled = true
        } else {
            self.pickerTextField.text = nil
            self.pickerTextField.isEnabled = false
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
