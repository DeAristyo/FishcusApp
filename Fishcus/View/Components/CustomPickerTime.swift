//
//  CustomPickerTime.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 17/11/23.
//

import UIKit


class CustomPickerTime: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    let timePicker = UIPickerView()
    var hours: [String] = []
    var minutes: [String] = []
    
    weak var timerDelegate: DelegatePickerTime?
    
    private var bgColor: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyColors.primaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SetupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupView()
    }
    
    
    func SetupView(){
        
        addSubview(bgColor)
        addSubview(timePicker)
        
        for hour in 0...2 { hours.append("\(hour) hours") }
        for minute in 0...59 { minutes.append("\(minute) min") }
        
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        SetupLayouts()
    }
    
    func SetupLayouts(){
        
        NSLayoutConstraint.activate([
            bgColor.topAnchor.constraint(equalTo: topAnchor),
            bgColor.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgColor.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgColor.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            timePicker.topAnchor.constraint(equalTo: topAnchor),
            timePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
        let selectedHours = hours[pickerView.selectedRow(inComponent: 0)].prefix(2)
        let selectedMinutes = minutes[pickerView.selectedRow(inComponent: 1)].prefix(2)
       
        let time = convertHourMinuteToSecondString("\(selectedHours)", "\(selectedMinutes)")
        
        timerDelegate?.sendFocusDuration(time: time )
        
        
    }
    
    func convertHourMinuteToSecondString(_ timeHour: String, _ timeMinute: String)-> String{
        var secondsHours = 0
        var secondMinutes = 0
        var resultSecond = 0
        
        if let hoursConvert = Int(removeWhitespacesFromString(mStr: timeHour)) {
            secondsHours = hoursConvert * 3600
        }else{
            return ""
        }
        
        if let minuteConvert = Int(removeWhitespacesFromString(mStr: timeMinute)) {
            secondMinutes = minuteConvert * 60
        }else{
            return ""
        }
        
        resultSecond = secondsHours+secondMinutes
        
        return "\(resultSecond)"
    }
    
    func removeWhitespacesFromString(mStr: String) -> String {
       let chr = mStr.components(separatedBy: .whitespaces)
       let resString = chr.joined()
       return resString
    }
    
}
