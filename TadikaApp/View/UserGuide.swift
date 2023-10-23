//
//  UserGuide.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 20/10/23.
//

import UIKit

class UserGuide: UIView {
    private var mascotImage : UIImageView = {
        let imgMascot = UIImageView()
        imgMascot.image = UIImage(named: "mascot-3")
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
        text.text = "“Let’s start fishing! During Focus session, you can start focusing on your tasks and..."
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
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
           
            mascotImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            mascotImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 100),
            
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rectangle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128),
            
        ])
        
        
    }
}

class UserGuide2: UIView {
    private var mascotImage : UIImageView = {
        let imgMascot = UIImageView()
        imgMascot.image = UIImage(named: "mascot-3")
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
        text.text = "“If you need to go out of the app or simply just want to take a break, you can pause by swiping up the Home button on your phone!”"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }()
    
    private var gesture: UILabel = {
        let label = UILabel()
        label.text = "Swipe up to take a break"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        addSubview(gesture)
        
        
        NSLayoutConstraint.activate([
           
            mascotImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            mascotImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 100),
            
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rectangle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128),
            
            gesture.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 45),
            gesture.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        
    }
}

class UserGuide3 : UIView {
    
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
        imgMascot.image = UIImage(named: "mascot-4")
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
        text.text = "“You only have 10 minutes of break! If you have reached the time limit, you can’t pause anymore. So use your time wisely!”"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
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

class UserGuide4: UIView {
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
        imgMascot.image = UIImage(named: "mascot-4")
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
        text.text = "“But for now, swipe down anywhere on the screen to resume your fishing session!”"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }()
    
    private var gesture: UILabel = {
        let label = UILabel()
        label.text = "Swipe down to continue"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        addSubview(gesture)
       
        
        NSLayoutConstraint.activate([
           
            userInfoOverlay.topAnchor.constraint(equalTo: topAnchor),
            userInfoOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            userInfoOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mascotImage.leadingAnchor.constraint(equalTo: userInfoOverlay.leadingAnchor, constant: 80),
            mascotImage.bottomAnchor.constraint(equalTo: userInfoOverlay.bottomAnchor, constant: -252),
            
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rectangle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128),
            
            gesture.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 45),
            gesture.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
        
        
    }
}


