//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by 장예진 on 5/22/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private lazy var datePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var selectedDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let years = [Int](1990...2050)
    let months = [Int](1...12)
    var days = [Int](1...31)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        selectedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedDateLabel)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectedDateLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            selectedDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        updateSelectedDateLabel()
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return days.count
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(years[row])
        case 1:
            return String(months[row])
        case 2:
            return String(days[row])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 || component == 0 {
            updateDays()
        }
        updateSelectedDateLabel()
    }
    
    private func updateDays() {
        let selectedYear = years[datePicker.selectedRow(inComponent: 0)]
        let selectedMonth = months[datePicker.selectedRow(inComponent: 1)]
        
        var maxDays = 31
        
        switch selectedMonth {
        case 4, 6, 9, 11:
            maxDays = 30
        case 2:
            maxDays = (selectedYear % 4 == 0 && (selectedYear % 100 != 0 || selectedYear % 400 == 0)) ? 29 : 28
        default:
            maxDays = 31
        }
        
        days = [Int](1...maxDays)
        datePicker.reloadComponent(2)
    }
    
    private func updateSelectedDateLabel() {
        let selectedYear = years[datePicker.selectedRow(inComponent: 0)]
        let selectedMonth = months[datePicker.selectedRow(inComponent: 1)]
        let selectedDay = days[datePicker.selectedRow(inComponent: 2)]
        
        selectedDateLabel.text = "Selecte your birthday: \(selectedYear)-\(String(format: "%02d", selectedMonth))-\(String(format: "%02d", selectedDay))"
    }
}
