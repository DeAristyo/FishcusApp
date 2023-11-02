//
//  ReusableViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit

class ReuseableInfoView: UIView{
    
    enum bgStyleEnum {
        case type1
        case type2
    }
    
    enum mascotIconEnum {
        case mascot1
        case mascot2
        case mascot3
        case mascot4
        case mascot5
        case mascot6
    }
    
    public private(set) var bgStyle: bgStyleEnum
    public private(set) var mascotIcon: mascotIconEnum
    public private(set) var labelText: String
    public private(set) var position: Bool
    
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
        imgMascot.contentMode = .scaleAspectFill
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
        
        return view
    }()
    
    private var labelInfo: UILabel = {
        // Auto layout, variables, and unit scale are not yet supported
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 297, height: 94)
        text.textColor = .white
        text.font = UIFont(name: "SFProRounded-Regular", size: 18)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        // Line height: 21.48 pt
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    
    
    init(bgStyle: bgStyleEnum, mascotIcon: mascotIconEnum, labelText: String, position: Bool ) {
        self.bgStyle = bgStyle
        self.mascotIcon = mascotIcon
        self.labelText = labelText
        self.position = position
        
        super.init(frame: .zero)
        SetupReusebaleInfoView()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupReusebaleInfoView(){
        ConfigBgStyle()
        ConfigMascotIcon()
        labelInfo.text = "\(labelText)"
        
        self.rectangle.addSubview(labelInfo)
        addSubview(userInfoOverlay)
        addSubview(mascotImage)
        addSubview(rectangle)
        
        NSLayoutConstraint.activate([
            userInfoOverlay.topAnchor.constraint(equalTo: topAnchor),
            userInfoOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            userInfoOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mascotImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            mascotImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: position ? -150 : 100),
            mascotImage.widthAnchor.constraint(equalToConstant: 82),
            mascotImage.heightAnchor.constraint(equalToConstant: 82),
            
            rectangle.topAnchor.constraint(equalTo: mascotImage.bottomAnchor),
            rectangle.widthAnchor.constraint(equalToConstant: 331),
            rectangle.heightAnchor.constraint(equalToConstant: 128),
            rectangle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            labelInfo.topAnchor.constraint(equalTo: rectangle.topAnchor),
            labelInfo.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 18),
            labelInfo.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -18),
            labelInfo.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor),
            
        ])
       
    }
    
    private func ConfigBgStyle(){
        switch bgStyle {
        case .type1:
            userInfoOverlay.layer.backgroundColor = UIColor.black.cgColor
            userInfoOverlay.alpha = 0.5
        case .type2:
            userInfoOverlay.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    private func ConfigMascotIcon(){
        
        switch mascotIcon {
        case .mascot1:
            mascotImage.image = UIImage(named: "mascot-new-1")
        case .mascot2:
            mascotImage.image = UIImage(named: "mascot-new-2")
        case .mascot3:
            mascotImage.image = UIImage(named: "mascot-new-3")
        case .mascot4:
            mascotImage.image = UIImage(named: "mascot-new-1")
        case .mascot5:
            mascotImage.image = UIImage(named: "mascot-new-2")
        case .mascot6:
            mascotImage.image = UIImage(named: "mascot-new-3")
        }
        
    }
    
    
    
}

class TimerPause: UIView {
    
    var timer: Timer?
    var totalPauseTimer = 600
    
    weak var delegate: DelegateProtocol?
    
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
    
    private var infoIcon: UIButton = {
        let image = UIButton(type: .custom)
        image.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPauseTimer()
       
    }
    
    private func setupPauseTimer(){
        addSubview(timerPauseContainer)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(infoIcon)
        
        label2.text = "\(convertTimerToString(time: TimeInterval(totalPauseTimer)))"
        
        NSLayoutConstraint.activate([
            timerPauseContainer.topAnchor.constraint(equalTo: topAnchor, constant: 68),
            timerPauseContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerPauseContainer.widthAnchor.constraint(equalToConstant: 351),
            timerPauseContainer.heightAnchor.constraint(equalToConstant: 160),
            
            infoIcon.topAnchor.constraint(equalTo: timerPauseContainer.topAnchor, constant: 10),
            infoIcon.trailingAnchor.constraint(equalTo: timerPauseContainer.trailingAnchor, constant: -10),
            infoIcon.widthAnchor.constraint(equalToConstant: 45),
            infoIcon.heightAnchor.constraint(equalToConstant: 45),
            
            label1.topAnchor.constraint(equalTo: timerPauseContainer.topAnchor, constant: 15),
            label1.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 15),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 7),
            label2.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 12),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 7),
            label3.leadingAnchor.constraint(equalTo: timerPauseContainer.leadingAnchor, constant: 15)
            
        ])
        
        infoIcon.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        
    }
    
    @objc func showInfo(){
        delegate?.changeShowInfo()
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
        headTitle.text = "Continue for another ... minutes to get fish or nothing at all"
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
