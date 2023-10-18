//
//  ReusableViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit

class UserInfoOverlay : UIView {
    
    private var userInfoOverlay: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.backgroundColor = UIColor.black.cgColor
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private var mascotImage : UIImageView = {
        let imgMascot = UIImageView()
        imgMascot.image = UIImage(named: "mascot-1")
        imgMascot.contentMode = .center
        imgMascot.translatesAutoresizingMaskIntoConstraints = false
        
        return imgMascot
    }()
    
    private var rectangle: UIView = {
       let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.282, green: 0.369, blue: 0.341, alpha: 0.8).cgColor
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        let text = UILabel()
        text.text = "Hey, Vicky! I’m your friend, x!"
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUserInfoOverlay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInfoOverlay()
    }
    
    private func setupUserInfoOverlay(){
        
        addSubview(userInfoOverlay)
        addSubview(mascotImage)
        addSubview(rectangle)
        
        
        NSLayoutConstraint.activate([
            userInfoOverlay.topAnchor.constraint(equalTo: topAnchor),
            userInfoOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            userInfoOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            mascotImage.centerXAnchor.constraint(equalTo: userInfoOverlay.centerXAnchor),
            mascotImage.centerYAnchor.constraint(equalTo: userInfoOverlay.centerYAnchor, constant: -150),
            
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rectangle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128)
        ])
        
        
    }
}


class UserInfoOverlay2 : UIView {
    
    private var mascotImage : UIImageView = {
        let imgMascot = UIImageView()
        imgMascot.image = UIImage(named: "mascot-2")
        imgMascot.contentMode = .center
        imgMascot.translatesAutoresizingMaskIntoConstraints = false
        
        return imgMascot
    }()
    
    private var rectangle: UIView = {
       let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.282, green: 0.369, blue: 0.341, alpha: 0.8).cgColor
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Auto layout, variables, and unit scale are not yet supported
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 297, height: 94)
        text.textColor = .white
        text.font = UIFont(name: "SFProRounded-Regular", size: 18)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        // Line height: 21.48 pt
        text.textAlignment = .center
        text.text = "“Ready to start? Shrimply tap the ‘Focus’ button to begin your fishing session!”"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUserInfoOverlay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInfoOverlay()
    }
    
    private func setupUserInfoOverlay(){
        
        addSubview(mascotImage)
        addSubview(rectangle)
        
        
        NSLayoutConstraint.activate([
           
            mascotImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            mascotImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rectangle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128)
        ])
        
        
    }
}
