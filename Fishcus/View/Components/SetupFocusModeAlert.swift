//
//  SetupFocusModeAlert.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 16/11/23.
//

import UIKit


class SetupFocusModeAlert: UIView, DelegatePickerTime, DelegateToggleSwitch{

    var focusDuration: Int = 0{
        didSet{
            if focusDuration < 300{
                delegateChangeScreen?.ShowAlertMinFocusDuration("Sorry, the minimum focus duration is 5 minutes!")
                btnStart.isEnabled = false
            }else{

                SetBreakDuration(focusDuration)
            }
        }
    }
    
    var breakDuration: Int = 0
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to do?"
        label.font = UIFont.rounded(ofSize: 17, weight: .bold)
        label.textColor = UIColor.MyColors.regularText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var inputTaskTextField: UITextField = {
        let textField = UITextField()
        let font = UIFont.rounded(ofSize: 17, weight: .bold)
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor(named: "regular-text")
        textField.placeholder = "Study Math"
        textField.font = UIFont.rounded(ofSize: 17, weight: .bold)
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Study Math",
                                                             attributes: [NSAttributedString.Key.font: font])
        textField.attributedPlaceholder = NSAttributedString(string: "Study Math",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.MyColors.primaryColor.withAlphaComponent(0.5)])
        textField.textColor = UIColor(named: "primaryColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private var focusDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "Focus Duration"
        label.font = UIFont.rounded(ofSize: 17, weight: .bold)
        label.textColor = UIColor.MyColors.regularText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var buttonPicker: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.MyColors.regularText
        button.setTitle("0 Min", for: .normal)
        button.titleLabel?.font = UIFont.rounded(ofSize: 17, weight: .bold)
        button.titleLabel?.textColor = UIColor.MyColors.primaryColor
        button.setTitleColor(UIColor.MyColors.primaryColor, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var inputTimeTextField: CustomPickerTime = {
        let textField = CustomPickerTime()
        textField.layer.zPosition = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private var breakDurationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Break Duration"
        label.font = UIFont.rounded(ofSize: 17, weight: .bold)
        label.textColor = UIColor.MyColors.regularText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var breakDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Min"
        label.font = UIFont.rounded(ofSize: 17, weight: .bold)
        label.textColor = UIColor.MyColors.regularText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var miniGamesLabel: UILabel = {
        let label = UILabel()
        label.text = "Mini-Games"
        label.font = UIFont.rounded(ofSize: 17, weight: .bold)
        label.textColor = UIColor.MyColors.regularText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var toggleSwitcher = ToggleSwitch()
    
    private var btnStart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-start"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegateChangeScreen: DelegateButtonStart?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SetupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupView()
    }
    
    func SetupView(){
       
        addSubview(titleLabel)
        addSubview(inputTaskTextField)
        addSubview(focusDurationLabel)
        addSubview(inputTimeTextField)
        addSubview(breakDurationTitleLabel)
        addSubview(breakDurationLabel)
        addSubview(miniGamesLabel)
        addSubview(toggleSwitcher)
        addSubview(btnStart)
        addSubview(buttonPicker)
        
        SetupLayout()
        
        SetupDelegate()
        
        inputTimeTextField.isHidden = true
        
        buttonPicker.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTap))
        self.addGestureRecognizer(gesture)
        
        btnStart.addTarget(self, action: #selector(changeScreen), for: .touchUpInside)
        btnStart.isEnabled = false
    }
    
    @objc func changeScreen(){
        guard let text = inputTaskTextField.text, !text.isEmpty else{
            delegateChangeScreen?.ShowAlertMinFocusDuration("Textfield must be fill")
            return
        }
        
        if focusDuration >= 300{
            btnStart.isEnabled = true
            delegateChangeScreen?.changeScreen()
        }else{
            delegateChangeScreen?.ShowAlertMinFocusDuration("Sorry, the minimum focus duration is 5 minutes!")
        }
        
    }
    
    @objc func gestureTap(){
        self.endEditing(true)
        delegateChangeScreen?.SendDataFocus(inputTaskTextField.text ?? "Empty", focusDuration, breakDuration)
        inputTimeTextField.isHidden = true
        buttonPicker.isEnabled = true
        toggleSwitcher.isEnabled = true
        btnStart.isEnabled = true
        
       
    }
    
    @objc func showPicker(){
        inputTimeTextField.isHidden = false
        buttonPicker.isEnabled = false
        btnStart.isEnabled = false
        toggleSwitcher.isEnabled = false
    }
    
    func sendFocusDuration(time: String) {
        focusDuration = Int(time) ?? 0
        let finalTime = ConvertSecondToMinutesString(time: TimeInterval(Int(time) ?? 0))
        buttonPicker.setTitle("\(finalTime) min", for: .normal)
    }
    
    func ToggleSwitchRun() {
        delegateChangeScreen?.SendValueToggle()
    }
    
    func SetupDelegate(){
        inputTimeTextField.timerDelegate = self
        toggleSwitcher.toggleSwitch = self
    }
    
    func SetupLayout(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            inputTaskTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            inputTaskTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputTaskTextField.widthAnchor.constraint(equalToConstant: 321),
            inputTaskTextField.heightAnchor.constraint(equalToConstant: 43),
            
            focusDurationLabel.topAnchor.constraint(equalTo: inputTaskTextField.bottomAnchor, constant: 35),
            focusDurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            
            buttonPicker.topAnchor.constraint(equalTo: inputTaskTextField.bottomAnchor, constant: 36.5),
            buttonPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            buttonPicker.widthAnchor.constraint(equalToConstant: 183),
            buttonPicker.heightAnchor.constraint(equalToConstant: 30),
            
            breakDurationTitleLabel.topAnchor.constraint(equalTo: focusDurationLabel.bottomAnchor, constant: 25),
            breakDurationTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            
            breakDurationLabel.topAnchor.constraint(equalTo: focusDurationLabel.bottomAnchor, constant: 25),
            breakDurationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            miniGamesLabel.topAnchor.constraint(equalTo: breakDurationTitleLabel.bottomAnchor, constant: 35),
            miniGamesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            
            toggleSwitcher.topAnchor.constraint(equalTo: breakDurationTitleLabel.bottomAnchor, constant: 32),
            toggleSwitcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            btnStart.topAnchor.constraint(equalTo: miniGamesLabel.bottomAnchor, constant: 50),
            btnStart.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            inputTimeTextField.topAnchor.constraint(equalTo: inputTaskTextField.bottomAnchor),
            inputTimeTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTimeTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTimeTextField.bottomAnchor.constraint(equalTo: btnStart.topAnchor)
            
        ])
    }
    
    func ConvertSecondToMinutesString(time: TimeInterval) -> String{
        let minute = Int(time) / 60
        
        return String(format: "%02i", minute)
    }
    
    func SetBreakDuration(_ focusDuration: Int){
        switch focusDuration {
        case 0...1499:
            breakDuration = 300
            breakDurationLabel.text = "\(ConvertSecondToMinutesString(time: TimeInterval(breakDuration))) min"
            break
        case 1500...2940:
            breakDuration = 480
            breakDurationLabel.text = "\(ConvertSecondToMinutesString(time: TimeInterval(breakDuration))) min"
            break
        case 3000...5340:
            breakDuration = 600
            breakDurationLabel.text = "\(ConvertSecondToMinutesString(time: TimeInterval(breakDuration))) min"
            break
        default:
            breakDuration = 900
            breakDurationLabel.text = "\(ConvertSecondToMinutesString(time: TimeInterval(breakDuration))) min"
            break
        }
    }
    
}
