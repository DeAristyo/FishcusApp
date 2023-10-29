//
//  podomoroAlertsView.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 29/10/23.
//

import UIKit

class PodomoroAlerts : UIView {
    
    weak var delegate: DelegateProtocol?
    
    private var alertContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.cornerRadius = 31
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var headTitle : UILabel = {
        let headTitle = UILabel()
        headTitle.frame = CGRect(x: 0, y: 0, width: 204, height: 52)
        headTitle.textColor = UIColor(named: "highlight-text")
        headTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.text = "You did great!"
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
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
        let headTitle = UILabel()
        headTitle.frame = CGRect(x: 0, y: 0, width: 276, height: 52)
        headTitle.textColor = UIColor(named: "regular-text")
        headTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.lineBreakMode = .byWordWrapping
        headTitle.text = "You deserve a 5 minutes rest."
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
    }()
    
    private var btnNo: UIButton = {
        let btn = UIButton()
        btn.setTitle("No Thanks", for: .normal)
        btn.setTitleColor(UIColor(named: "regular-text"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private var btnTake: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn-take"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPodomoroAlert()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPodomoroAlert()
    }
    
    private func setupPodomoroAlert()
    {

        addSubview(alertContainer)
        addSubview(headTitle)
        addSubview(line)
        addSubview(contentLabel)
        addSubview(btnNo)
        addSubview(btnTake)

        
        NSLayoutConstraint.activate([
            
            alertContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertContainer.widthAnchor.constraint(equalToConstant: 322),
            alertContainer.heightAnchor.constraint(equalToConstant: 235),
        
            headTitle.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: 25),
            headTitle.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
            headTitle.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
            headTitle.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            
            line.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 13.5),
            line.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 282),
            
            contentLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 13.5),
            contentLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: 276),
            contentLabel.heightAnchor.constraint(equalToConstant: 50),
            
            btnNo.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 25),
            btnNo.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: 51),
            
            btnTake.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 25),
            btnTake.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -15)
            
        ])
        
      
        btnNo.addTarget(self, action: #selector(takeNo), for: .touchUpInside)
        btnTake.addTarget(self, action: #selector(take), for: .touchUpInside)
    }
    
    @objc func takeNo(){
        delegate?.continuePodomoroAlert()
    }
    
    @objc func take(){
        delegate?.takePodomoroAlert()
    }
    
}



