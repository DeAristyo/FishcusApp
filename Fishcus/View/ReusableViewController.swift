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
    
    enum labelTextStyleEnum{
        case label1
        case label2
        case label3
        case label4
        case label5
        case label6
        case label7
        case label8
        case label9
        case label10
        case label11
        case label12
        case label13
        case label14
    }
    
    public private(set) var bgStyle: bgStyleEnum
    public private(set) var mascotIcon: mascotIconEnum
    public private(set) var labelText: String
    public private(set) var position: Bool
    public private(set) var labelTextStyle: labelTextStyleEnum
    
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
        text.font = .rounded(ofSize: 18, weight: .regular)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        // Line height: 21.48 pt
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    
    
    init(bgStyle: bgStyleEnum, mascotIcon: mascotIconEnum, labelText: String, position: Bool, labelTextStyle: labelTextStyleEnum ) {
        self.bgStyle = bgStyle
        self.mascotIcon = mascotIcon
        self.labelText = labelText
        self.position = position
        self.labelTextStyle = labelTextStyle
        
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
        ConfigLabelTextStyle()
        
        self.rectangle.addSubview(labelInfo)
        addSubview(userInfoOverlay)
        addSubview(mascotImage)
        addSubview(rectangle)
        
        NSLayoutConstraint.activate([
            userInfoOverlay.topAnchor.constraint(equalTo: topAnchor),
            userInfoOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            userInfoOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mascotImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 100),
            mascotImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: position ? -100 : -40),
            mascotImage.widthAnchor.constraint(equalToConstant: 117),
            mascotImage.heightAnchor.constraint(equalToConstant: 182),
            
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
    
    private func ConfigLabelTextStyle(){
        switch labelTextStyle {
        case .label1:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "Oceano!")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label2:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "Shrimply")
            let textRange2 = (theText as NSString).range(of: "‘Focus’")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange2)
            labelInfo.attributedText =  attribute
            
        case .label3:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "swiping up the Home button on your phone!")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label4:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "can’t pause")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "alert-color") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label5:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "swipe down anywhere")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label6:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "moving your phone up and hold it")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label7:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "timer visible or")
            let textRange2 =  (theText as NSString).range(of: "invisible")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange2)
            labelInfo.attributedText =  attribute
            
        case .label8:
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "info.circle.fill")?.withTintColor(.white)

            let attribute = NSMutableAttributedString(string: "If you have questions or need more details, click the ‘")
            attribute.append(NSAttributedString(attachment: imageAttachment))
            attribute.append(NSAttributedString(string: "‘ button for more information."))

            let theText = "\(attribute.string)"
            let textRange =  (theText as NSString).range(of: "click the ‘")
            let textRange2 =  (theText as NSString).range(of: "‘ button for more information.")
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange2)
            labelInfo.attributedText =  attribute
            
        case .label9:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "5 minutes")
            let textRange2 =  (theText as NSString).range(of: "The more you focus, the more break time you'll receive.")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange2)
            labelInfo.attributedText =  attribute
            
        case .label10:
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "End your focus")
            let textRange2 =  (theText as NSString).range(of: "lifting your cellphone")
            let textRange3 = (theText as NSString).range(of: "pulling in a fishing rod.")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "alert-color") ?? UIColor.white, range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange3)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "rare-color") ?? UIColor.white, range: textRange3)
            labelInfo.attributedText =  attribute
            
        case .label11 :
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "Time to input your study milestones.")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label12 :
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "The duration you study will determine the variety of fish you can catch.")
            let textRange2 = (theText as NSString).range(of: "“Cheers to your study milestone!")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange2)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
           
        case .label13 :
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "Share your latest adventure")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "rare-color") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
            
        case .label14 :
            let theText = "\(self.labelText)"
            let textRange =  (theText as NSString).range(of: "look at your Focus History here")
            let textRang2 =  (theText as NSString).range(of: "\"Take a")
            let textRang3 =  (theText as NSString).range(of: "see how far you've come.")
            let attribute = NSMutableAttributedString.init(string: theText)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRange)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRang2)
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.rounded(ofSize: 18, weight: .bold), range: textRang3)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "highlight-text") ?? UIColor.white, range: textRange)
            labelInfo.attributedText =  attribute
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
        myLabel1.font = UIFont.rounded(ofSize: 18, weight: .bold)
        myLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel1
    }()
    
    private var label2: UILabel = {
        let myLabel2 = UILabel()
        myLabel2.text = "00:00"
        myLabel2.textColor = UIColor(named: "highlight-text")
        myLabel2.font = UIFont.rounded(ofSize: 50, weight: .bold)
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel2
    }()
    
    private var label3: UILabel = {
        let myLabel3 = UILabel()
        myLabel3.text = "Break Time"
        myLabel3.textColor = UIColor(named: "regular-text")
        myLabel3.font = UIFont.rounded(ofSize: 18, weight: .bold)
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
        headTitle.font = UIFont.rounded(ofSize: 22, weight: .bold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.text = "Are you sure?\nYou might lose the fish!"
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
    
    var contentLabel: UILabel = {
        let headTitle = UILabel()
        headTitle.frame = CGRect(x: 0, y: 0, width: 276, height: 52)
        headTitle.textColor = UIColor(named: "regular-text")
        headTitle.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        headTitle.numberOfLines = 0
        headTitle.textAlignment = .center
        headTitle.lineBreakMode = .byWordWrapping
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return headTitle
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
            headTitle.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor, constant: 30),
            headTitle.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -30),
            headTitle.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            
            line.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 13.5),
            line.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 282),
            
            contentLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 13.5),
            contentLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: 276),
            contentLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    
    }
    
   
}
