//
//  ViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 23/10/23.
//

import UIKit



class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let gacha = GachaSystem()
    let getData = GetDataFishing.getData()
    let timePicker = UIPickerView()
    var hours: [String] = []
    var minutes: [String] = []
    let showPickerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let button = UIButton(type: .system)
//        button.setTitle("Pull", for: .normal)
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(gachaPull), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(button)
//        
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.widthAnchor.constraint(equalToConstant: 100),
//            button.heightAnchor.constraint(equalToConstant: 50)
//        ])
        
        // Populate the hours and minutes arrays
        for hour in 0...24 { hours.append("\(hour) hours") }
        for minute in 0...59 { minutes.append("\(minute) min") }
        
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.isHidden = true
        
        setupTimePicker()

       
        showPickerButton.setTitle("Show Time Picker", for: .normal)
        showPickerButton.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
        showPickerButton.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(showPickerButton)
        
        NSLayoutConstraint.activate([
            showPickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPickerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)

    }
    
    @objc func gestureTap(){
        print("tap")
        timePicker.isHidden = true
        showPickerButton.isHidden = false
    }
    
    @objc func showTimePicker() {
        timePicker.isHidden = false
        showPickerButton.isHidden = true
    }
    
    func setupTimePicker() {
        view.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the picker, adjust as necessary
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timePicker.widthAnchor.constraint(equalToConstant: 250),
            timePicker.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Customization
        timePicker.backgroundColor = .darkGray
        
    }
    
    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // for hours and minutes
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? hours.count : minutes.count
    }
    
    // UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? hours[row] : minutes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle the picker selection
        let selectedHours = hours[pickerView.selectedRow(inComponent: 0)]
        let selectedMinutes = minutes[pickerView.selectedRow(inComponent: 1)]
        
        print("Selected time: \(selectedHours.prefix(2)) \(selectedMinutes.prefix(2))")
    }
    
    @objc func gachaPull(){
        gacha.gachaPull()
        print(gacha.setFish)
        print(gacha.setRarerity)
        gacha.reset()
    }
    
    func convertHoursToSecond(_ time: TimeInterval){
        
    }
    
    
}
