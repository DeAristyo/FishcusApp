//
//  MiniAlerts.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 09/11/23.
//

import UIKit

class OnFocusAlerts: UIView {
    
    enum iconChoose{
        case icon1
        case icon2
    }
    
    public private(set) var icon: iconChoose
    public private(set) var labelInfo: String
    
    private var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.rounded(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "regular-text")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var iconAlert: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(icon: iconChoose, labelInfo: String) {
        self.icon = icon
        self.labelInfo = labelInfo
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupOnFocusAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupOnFocusAlert()
    {
        setupIcon()
        setupLabel()
        
        addSubview(container)
        container.addSubview(label)
        container.addSubview(iconAlert)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 321),
            container.heightAnchor.constraint(equalToConstant: 70),
            
            iconAlert.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconAlert.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: icon == .icon1 ? 14 : 26),
            iconAlert.widthAnchor.constraint(equalToConstant: icon == .icon1 ? 46 : 16),
            iconAlert.heightAnchor.constraint(equalToConstant: icon == .icon1 ? 41 : 22),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconAlert.trailingAnchor, constant: icon == .icon1 ? 0 : 15 ),
            label.widthAnchor.constraint(equalToConstant: 249),
            label.heightAnchor.constraint(equalToConstant: 56)
        ])

    }
    

    private func setupIcon(){
        switch icon {
        case .icon1:
            iconAlert.image = UIImage(named: "icon-yoga")
        case .icon2:
            iconAlert.image = UIImage(named: "icon-podomoro")
        }
    }
    
    private func setupLabel(){
        label.text = labelInfo
    }
    
}
