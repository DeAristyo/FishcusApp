//
//  BreakAlert.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 18/11/23.
//

import UIKit

class BreakAlert: UIView {
    
    enum BreakTypeEnum{
        case breakType
        case finishType
    }
    
    
    public private(set) var breakType: BreakTypeEnum
    
    init(breakType: BreakTypeEnum) {
        self.breakType = breakType
        
        super.init(frame: .zero)
        SetupAlertType()
        SetupView()
        SetupLayouts()
    }
    
    private var overlayBackground: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.backgroundColor = UIColor.black.cgColor
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var containerAlert: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.MyColors.primaryColor
        view.layer.cornerRadius = 31
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var headLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 30, weight: .bold)
        label.textColor = UIColor.MyColors.secondaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var line: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        line.layer.borderWidth = 4.0
        line.layer.borderColor = UIColor(named: "regular-text")?.cgColor
        line.translatesAutoresizingMaskIntoConstraints = false
        
        return line
    }()
    
    private var contentLabel: UILabel = {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 276, height: 52)
        title.textColor = UIColor(named: "regular-text")
        title.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        title.numberOfLines = 0
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var btnDynamic: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var btnFinish: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn-finish-outline"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var breakAlertDelegate: DelegateProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("Not implement initializers")
    }
    
    func SetupView(){
        addSubview(overlayBackground)
        addSubview(containerAlert)
        
        containerAlert.addSubview(headLabel)
        containerAlert.addSubview(line)
        containerAlert.addSubview(contentLabel)
        containerAlert.addSubview(btnDynamic)
        containerAlert.addSubview(btnFinish)
        
        btnFinish.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
    }
    
    func SetupLayouts(){
        NSLayoutConstraint.activate([
            
            overlayBackground.topAnchor.constraint(equalTo: topAnchor),
            overlayBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerAlert.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerAlert.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerAlert.widthAnchor.constraint(equalToConstant: 321),
            containerAlert.heightAnchor.constraint(equalToConstant: 292),
            
            headLabel.topAnchor.constraint(equalTo: containerAlert.topAnchor, constant: 35),
            headLabel.centerXAnchor.constraint(equalTo: containerAlert.centerXAnchor),
            
            line.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 13.5),
            line.centerXAnchor.constraint(equalTo: containerAlert.centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 282),
            
            contentLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            contentLabel.centerXAnchor.constraint(equalTo: containerAlert.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: 270),
            contentLabel.heightAnchor.constraint(equalToConstant: 50),
            
            btnDynamic.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            btnDynamic.centerXAnchor.constraint(equalTo: containerAlert.centerXAnchor),
            
            btnFinish.topAnchor.constraint(equalTo: btnDynamic.bottomAnchor, constant: 15),
            btnFinish.centerXAnchor.constraint(equalTo: containerAlert.centerXAnchor),
            
        ])
    }
    
    
    func SetupAlertType(){
        switch breakType {
        case .breakType:
            headLabel.text = "Fantastic catch!"
            contentLabel.text = "Ready for a break? Or do you want to wrap up this session?"
            btnDynamic.setImage(UIImage(named: "btn-break"), for: .normal)
            btnDynamic.addTarget(self, action: #selector(breakAction), for: .touchUpInside)
            
        case .finishType:
            headLabel.text = "Break time’s over!"
            contentLabel.text = "Do you still want to continue your study session?"
            btnDynamic.setImage(UIImage(named: "btn-continue-alert"), for: .normal)
            btnDynamic.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        }
    }
    
    
    @objc func breakAction(){
        breakAlertDelegate?.breakBtn()
    }
    
    @objc func continueAction(){
        breakAlertDelegate?.continueBtn()
    }
    
    @objc func finishAction(){
        breakAlertDelegate?.finishBtn()
    }
    
    
    
}
