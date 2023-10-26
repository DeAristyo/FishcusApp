//
//  ReusableViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit
import WidgetKit

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
        text.text = "Hey, Player! I’m your friend, x!"
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

class TimerPause: UIView {
    
    var timer: Timer?
    var totalPauseTimer = 600
    var showInfoAction : (() -> Void)?
    var show: DelegateProtocol?
    
    private var timerPauseContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.cornerRadius = 25
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var label1: UILabel = {
        let myLabel1 = UILabel()
        myLabel1.text = "You Have"
        myLabel1.textColor = UIColor(named: "regular-text")
        myLabel1.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        myLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel1
    }()
    
    private var label2: UILabel = {
        let myLabel2 = UILabel()
        myLabel2.text = "00:00"
        myLabel2.textColor = UIColor(named: "highlight-text")
        myLabel2.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel2
    }()
    
    private var label3: UILabel = {
        let myLabel3 = UILabel()
        myLabel3.text = "Break Time"
        myLabel3.textColor = UIColor(named: "regular-text")
        myLabel3.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        myLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel3
    }()
    
//    private var infoIcon: UIImageView = {
//       let image = UIImageView()
//        image.image = UIImage(systemName: "info.circle.fill")
//        image.tintColor = .white
//        image.contentMode = .center
//        image.translatesAutoresizingMaskIntoConstraints = false
//        
//        return image
//    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPauseTimer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPauseTimer()
//        let infoGesture = UITapGestureRecognizer(target: self, action: #selector(showInfo))
//        infoIcon.isUserInteractionEnabled = true
//        infoIcon.addGestureRecognizer(infoGesture)
    }
    
    private func setupPauseTimer(){
        addSubview(timerPauseContainer)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
//        addSubview(infoIcon)
        
        label2.text = "\(convertTimerToString(time: TimeInterval(totalPauseTimer)))"
        
        
        NSLayoutConstraint.activate([
            timerPauseContainer.topAnchor.constraint(equalTo: topAnchor, constant: 68),
            timerPauseContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerPauseContainer.widthAnchor.constraint(equalToConstant: 351),
            timerPauseContainer.heightAnchor.constraint(equalToConstant: 160),
            
//            infoIcon.topAnchor.constraint(equalTo: timerPauseContainer.topAnchor, constant: 10),
//            infoIcon.trailingAnchor.constraint(equalTo: timerPauseContainer.trailingAnchor, constant: -10),
//            infoIcon.widthAnchor.constraint(equalToConstant: 44),
//            infoIcon.heightAnchor.constraint(equalToConstant: 44),
            
            label1.topAnchor.constraint(equalTo: timerPauseContainer.topAnchor, constant: 15),
            label1.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 15),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 7),
            label2.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 12),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 7),
            label3.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 15)
            

            
        ])
        
       
    }
    
    @objc func showInfo(){
        showInfoAction?()
    }
    
    func startPauseTimer(){
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updatePauseTimer), userInfo: nil, repeats: true)
    }
    
    func pauseTimer(){
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    @objc func updatePauseTimer(){
        
        if totalPauseTimer >= 0 {
            totalPauseTimer -= 1
            let currentPauseTime = convertTimerToString(time: TimeInterval(totalPauseTimer))
            print(currentPauseTime)
            label2.text = currentPauseTime
            
            let sharedDefaults = UserDefaults(suiteName: "group.75VHUVZJF4.com.vicky.tadikaapp")
            sharedDefaults?.set(currentPauseTime, forKey: "currentTime")
            WidgetCenter.shared.reloadAllTimelines()
        }else{
            timer?.invalidate()
        }
       
    }
    
    func convertTimerToString(time: TimeInterval) -> String{
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
}


class EndFocus : UIView {
    
    
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
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.cornerRadius = 31
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var headTitle : UILabel = {
        let headTitle = UILabel()
        headTitle.frame = CGRect(x: 0, y: 0, width: 204, height: 52)
        headTitle.textColor = UIColor(named: "highlight-text")
        headTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.text = "Are you sure want to end focus mode?"
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
        headTitle.text = "Move your fishing hook by move your phone up and down"
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
    }()
    
//    private var btnContinue: UIImageView = {
//       let image = UIImageView()
//        image.image = UIImage(named: "btn-finish")
//        image.contentMode = .center
//        image.translatesAutoresizingMaskIntoConstraints = false
//        
//        return image
//    }()
    
//    private var endHome: EndFocusBack = {
//        let view = EndFocusBack()
//        view.layer.zPosition = 13
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        return view
//    }()
    
    
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
//        addSubview(btnContinue)
//        addSubview(endHome)
        
//        endHome.alpha = 0.0
        
        NSLayoutConstraint.activate([
//            endHome.topAnchor.constraint(equalTo: topAnchor),
//            endHome.leadingAnchor.constraint(equalTo: leadingAnchor),
//            endHome.trailingAnchor.constraint(equalTo: trailingAnchor),
//            endHome.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
            
//            btnContinue.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 30),
//            btnContinue.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor)
            
        ])
        
      
    }
    
   
}

class EndFocusBack : UIView {

    private var bgEndFocus: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var headTitle : UILabel = {
        let headTitle = UILabel()
        headTitle.frame = CGRect(x: 0, y: 0, width: 204, height: 52)
        headTitle.textColor = UIColor(named: "highlight-text")
        headTitle.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.text = "Cool!"
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
        headTitle.text = "During the focus session you already had, you got fish!"
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
    }()
    
    private var btnContinue: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "btn-backmain")
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
       
        addSubview(headTitle)
        addSubview(line)
        addSubview(contentLabel)
//        addSubview(btnContinue)
        
        NSLayoutConstraint.activate([
            bgEndFocus.topAnchor.constraint(equalTo: topAnchor),
            bgEndFocus.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgEndFocus.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgEndFocus.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            headTitle.centerXAnchor.constraint(equalTo: bgEndFocus.centerXAnchor),
            headTitle.centerYAnchor.constraint(equalTo: bgEndFocus.centerYAnchor, constant: -100),
            
            line.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 13.5),
            line.centerXAnchor.constraint(equalTo: bgEndFocus.centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 282),
            
            contentLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 13.5),
            contentLabel.centerXAnchor.constraint(equalTo: bgEndFocus.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: 276),
            contentLabel.heightAnchor.constraint(equalToConstant: 50),
            
//            btnContinue.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 55),
//            btnContinue.centerXAnchor.constraint(equalTo: bgEndFocus.centerXAnchor)
            
        ])
        
//        let btnFinishGesture = UITapGestureRecognizer(target: self, action: #selector(btnFinish))
//        btnContinue.isUserInteractionEnabled = true
//        btnContinue.addGestureRecognizer(btnFinishGesture)
    }
    
//    @objc func btnFinish(){
//       
//    }
}
