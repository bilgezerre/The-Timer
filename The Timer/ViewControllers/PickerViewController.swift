//
//  PickerViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import Foundation
import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    public var pickerDataArray = [String]()
    public var filterSelection: Filter = .none
    var returnForUpdate: ((_ filterSelection: Filter) -> Void)?
    var selected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
//    Ui implementation and filter selection
    func initViews() {
        switch filterSelection {
        case .explosiveness:
            self.selected = 0
        case .endurance:
            self.selected = 1
        case .none:
            self.selected = 2
        }
        
        toolBar.barTintColor = .lightGray
        pickerView.backgroundColor = .white
        doneButton.tintColor = .white
        preparePickerView()
    }
    
//    prepare pickerView by initiliazing delegate&datasource and selected row
    func preparePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selected , inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
    }
    
//    implement selected filter after pressing done button in toolbar
    @IBAction func doneButton(_ sender: Any) {
        self.returnForUpdate?(self.filterSelection)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerView Delegate & Datasource
//displays the picker view elements in pickerview
extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataArray[row]
   }

   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       let selectedRow = pickerDataArray[row]
       switch selectedRow {
        case "Explosiveness":
           filterSelection = .explosiveness
           selected = 0
       case "Endurance":
           filterSelection = .endurance
           selected = 1
       default:
           filterSelection = .none
           selected = 2
       }
   }
}

