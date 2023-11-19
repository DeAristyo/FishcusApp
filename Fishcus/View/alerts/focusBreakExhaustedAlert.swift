//
//  focusBreakExhaustedAlert.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 29/10/23.
//

import UIKit

class FocusBreakExhausted : UIView {
    
    weak var delegate: DelegateProtocol?
    
    private var bgEndFocus: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.backgroundColor = UIColor.black.cgColor
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var alertContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "warning-color")
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
        headTitle.text = "Sorry :("
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
        headTitle.text = "You spend too much time on break, unfortunately you didn't get any fish.l"
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
    }()
    
    private var btnBack: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn-back"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupEndFocus()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEndFocus()
    }
    
    private func setupEndFocus()
    {
        addSubview(bgEndFocus)
        addSubview(alertContainer)
        addSubview(headTitle)
        addSubview(line)
        addSubview(contentLabel)
        addSubview(btnBack)

        
        NSLayoutConstraint.activate([
            
            bgEndFocus.topAnchor.constraint(equalTo: topAnchor),
            bgEndFocus.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgEndFocus.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgEndFocus.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alertContainer.centerXAnchor.constraint(equalTo: bgEndFocus.centerXAnchor),
            alertContainer.centerYAnchor.constraint(equalTo: bgEndFocus.centerYAnchor),
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
            
            btnBack.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 32),
            btnBack.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor)
            
        ])
        
//        btnBack.addTarget(self, action: #selector(btnBackAction), for: .touchUpInside)
    }
    
//    @objc func btnBackAction(){
//        delegate?.dismissBreakExhausted()
//    }
   
}
