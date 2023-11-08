//
//  FocusViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 17/10/23.
//

import UIKit
import CoreMotion
import CoreHaptics

class FocusViewController: UIViewController, DelegateProtocol  {
    func dismissBreakExhausted() {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            self.breakExhausted.alpha = 0.0
            self.timer?.invalidate()
            startTimer()
        })
    }
    
    func takePodomoroAlert() {
        timerPauseContainer.totalPauseTimer += 300
        UIView.animate(withDuration: 0.4, animations: {
            self.timerPauseContainer.alpha = 1.0
            self.iconStop.alpha = 0.0
            self.stopContainer.alpha = 0.0
            self.mainBg.image = UIImage(named: "bg-pause")
            self.swipeUpIcon.image = UIImage(named: "icon-swipe-down")
            self.swipeUpLabel.text = "Swipe down to resume"
            self.hideIcon.alpha = 0.0
            self.hideTimer.alpha = 0.0
            self.timerLabel.alpha = 0.0
            self.timerShownContainer.alpha = 0.0
            self.hideTimerIcon.alpha = 0.0
            self.podomoroAlerts.alpha = 0.0
        })
        
        complexSuccess()
        
        if timer != nil {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func continuePodomoroAlert() {
        timerPauseContainer.totalPauseTimer += 300
        UIView.animate(withDuration: 0.5, animations: {
            self.podomoroAlerts.alpha = 0.0
        })
    }
    
    
    let gachaSytem = GachaSystem()
    var myUserDefault = UserDefaults.standard
    var timer: Timer?
    var engine: CHHapticEngine?
    var showInfo = false
    var infoStep = 0
    var podomoroTime = 0
    var podomoroStep = 1
    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.rounded(ofSize: 20, weight: .semibold)
        timerLabel.textColor = UIColor(named: "regular-text")
        timerLabel.layer.zPosition = 12
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    var timerStart: Int = 0
    
    let motionManager = CMMotionManager()
    let motionThreshold: Double = 5.0 // Adjust the threshold as needed
    
    
    private var mainBg: UIImageView = {
        let fishing =  UIImageView()
        fishing.image = UIImage(named: "bg-latest")
        fishing.contentMode = .scaleAspectFill
        fishing.layer.zPosition = 1
        fishing.translatesAutoresizingMaskIntoConstraints = false
        
        return fishing
    }()
    
    private var iconStop: UIButton = {
        let stop = UIButton(type: .custom)
        stop.setImage(UIImage(named: "icon-stop"), for: .normal)
        stop.contentMode = .scaleAspectFill
        stop.layer.zPosition = 14
        stop.translatesAutoresizingMaskIntoConstraints = false
        
        return stop
    }()
    
    private var iconCancel: UIButton = {
        let stop = UIButton(type: .custom)
        stop.setImage(UIImage(named: "icon-cancel"), for: .normal)
        stop.contentMode = .scaleAspectFill
        stop.layer.zPosition = 14
        stop.translatesAutoresizingMaskIntoConstraints = false
        
        return stop
    }()
    
    
    var timerPauseContainer: TimerPause = {
        let view = TimerPause()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var endFocus: EndFocus = {
        let view = EndFocus()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private var infoLabel: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Auto layout, variables, and unit scale are not yet supported
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 297, height: 94)
        text.textColor = UIColor(named: "primaryColor")
        text.font = UIFont.rounded(ofSize: 14, weight: .semibold)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        // Line height: 21.48 pt
        text.textAlignment = .center
        text.text = "You are allowed to open other apps. When the timer reach its limit, you can’t pause anymore."
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
    
    private var btnContinue: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "btn-finish")
        image.contentMode = .center
        image.layer.zPosition = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var endHome: EndFocusBack = {
        let view = EndFocusBack()
        view.layer.zPosition = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var btnBackHome: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "btn-backmain")
        image.contentMode = .center
        image.layer.zPosition = 13
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var hideTimer: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 12
        view.layer.cornerRadius = view.frame.size.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var hideIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon-hide")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var stopContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 13
        view.layer.cornerRadius = view.frame.size.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var userGuideInfo: [ReuseableInfoView] = [
        ReuseableInfoView(bgStyle: .type2, mascotIcon: .mascot3, labelText: "“Let’s start fishing! During Focus session, you can start focusing on your tasks and...", position: false, labelTextStyle: .label3),
        ReuseableInfoView(bgStyle: .type2, mascotIcon: .mascot3, labelText: "“If you need to go out of the app or simply just want to take a break, you can pause by swiping up the Home button on your phone!”", position: false, labelTextStyle: .label3),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot2, labelText: "“You can make the timer visible or invisible as you like. It's up to you.”", position: false, labelTextStyle: .label7),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot4, labelText: "“You only have 10 minutes of break! If you have reached the time limit, you can’t pause anymore. So use your time wisely!”", position: false, labelTextStyle: .label4),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot5, labelText: "If you're unsure, click here for more information.", position: false, labelTextStyle: .label8),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot6, labelText: "“Earn 5 minutes of break time for every 20 minutes of productive focus. The more you focus, the more break time you'll receive.”", position: false, labelTextStyle: .label9),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot1, labelText: "\"Finished studying? End your focus mode by lifting your cellphone like you're pulling in a fishing rod.\"", position: false, labelTextStyle: .label10),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot2, labelText: "“Ready to spill the study tea? Time to input your study milestones. We're crafting your own study map to discover your progress.”", position: false, labelTextStyle: .label11)
    ]
    
    private var swipeUpIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-up")
        view.contentMode = .scaleAspectFill
        view.layer.zPosition = 12
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var swipeUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Pause"
        label.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "regular-text")
        label.layer.zPosition = 12
        label.alpha = 0.0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var timerShownContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 26
        
        return view
    }()
    
    private var hideTimerIcon: UIButton = {
        let view = UIButton(type: .custom)
        view.contentMode = .scaleAspectFill
        view.setImage(UIImage(named: "icon-show"), for: .normal)
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var infoEndSession: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private var infoPodomoro: UILabel = {
        let label = UILabel()
        label.text = "You get a +5 minutes rest!"
        label.font = UIFont.rounded(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "regular-text")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var infoEndSessionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull out your phone to finish the task"
        label.textAlignment = .center
        label.font = UIFont.rounded(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "regular-text")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var infoEndSessionIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "icon-shake")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var bgInputTask: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var containerInputTask: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 11
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var inputTaskTitle: UILabel = {
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 297, height: 94)
        text.textColor = .white
        text.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.layer.zPosition = 11
        // Line height: 21.48 pt
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    private var inputTaskTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(named: "regular-text")
        textField.textAlignment = .center
        textField.textColor = UIColor(named: "primaryColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private var inputTaskBtn: UIButton = {
        let image = UIButton(type: .custom)
        image.setImage(UIImage(named: "btn-continue"), for: .normal)
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var podomoroAlerts: PodomoroAlerts = {
        let view = PodomoroAlerts()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var breakExhausted : FocusBreakExhausted = {
        let view = FocusBreakExhausted()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var alertOnFocus: OnFocusAlerts = {
        let view = OnFocusAlerts(icon: .icon1, labelInfo: "You are currently in Focus Mode.")
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var alertOnPodomoro: OnFocusAlerts = {
        let view = OnFocusAlerts(icon: .icon2, labelInfo: "Study 20 min, break 5 min, repeat for more breaks!")
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        timerPauseContainer.delegate = self
        breakExhausted.delegate = self
        podomoroAlerts.delegate = self
        breakExhausted.alpha = 0.0
        podomoroAlerts.alpha = 0.0
        timerPauseContainer.alpha = 0.0
        endFocus.alpha = 0.0
        iconCancel.alpha = 0.0
        infoLabel.alpha = 0.0
        endHome.alpha = 0.0
        btnContinue.alpha = 0.0
        btnBackHome.alpha = 0.0
        hideIcon.alpha = 0.0
        hideTimer.alpha = 0.0
        infoEndSession.alpha = 0.0
        infoEndSessionIcon.alpha = 0.0
        infoEndSessionLabel.alpha = 0.0
        bgInputTask.alpha = 0.0
        containerInputTask.alpha = 0.0
        inputTaskBtn.alpha = 0.0
        inputTaskTitle.alpha = 0.0
        inputTaskTextField.alpha = 0.0
        endFocus.timerStart = timerStart
        alertOnPodomoro.alpha = 0.0
        swipeUpIcon.alpha = 0.0
        swipeUpLabel.alpha = 0.0
        
        
        
        view.addSubview(breakExhausted)
        
        NSLayoutConstraint.activate([
            breakExhausted.topAnchor.constraint(equalTo: view.topAnchor),
            breakExhausted.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breakExhausted.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breakExhausted.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(podomoroAlerts)
        
        NSLayoutConstraint.activate([
            podomoroAlerts.topAnchor.constraint(equalTo: view.topAnchor),
            podomoroAlerts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            podomoroAlerts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            podomoroAlerts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if ((myUserDefault.data(forKey: "focusData")?.isEmpty) == nil){
            let initialShowInfo = userGuideInfo[0]
            initialShowInfo.layer.zPosition = 12
            
            self.view.addSubview(initialShowInfo)
            
            NSLayoutConstraint.activate([
                initialShowInfo.topAnchor.constraint(equalTo: view.topAnchor),
                initialShowInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                initialShowInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                initialShowInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let guideInfoGestureRecog = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
            initialShowInfo.isUserInteractionEnabled = true
            initialShowInfo.addGestureRecognizer(guideInfoGestureRecog)
            
        }else{
            for myIndex in userGuideInfo{
                myIndex.removeFromSuperview()
            }
            
            //            swipeUpIcon.alpha = 1.0
            //            swipeUpLabel.alpha = 1.0
        }
        
        view.addSubview(hideTimer)
        
        NSLayoutConstraint.activate([
            hideTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            hideTimer.widthAnchor.constraint(equalToConstant: 44),
            hideTimer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        hideTimer.addSubview(hideIcon)
        
        NSLayoutConstraint.activate([
            hideIcon.centerXAnchor.constraint(equalTo: hideTimer.centerXAnchor),
            hideIcon.centerYAnchor.constraint(equalTo: hideTimer.centerYAnchor, constant: 2),
            hideIcon.widthAnchor.constraint(equalToConstant: 23),
            hideIcon.heightAnchor.constraint(equalToConstant: 9)
        ])
        
        
        view.addSubview(endHome)
        
        NSLayoutConstraint.activate([
            endHome.topAnchor.constraint(equalTo: view.topAnchor),
            endHome.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endHome.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endHome.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.widthAnchor.constraint(equalToConstant: 298),
            infoLabel.heightAnchor.constraint(equalToConstant: 143)
        ])
        
        view.addSubview(endFocus)
        
        NSLayoutConstraint.activate([
            endFocus.topAnchor.constraint(equalTo: view.topAnchor),
            endFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(btnContinue)
        
        NSLayoutConstraint.activate([
            btnContinue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContinue.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80)
        ])
        
        view.addSubview(btnBackHome)
        NSLayoutConstraint.activate([
            btnBackHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnBackHome.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90)
        ])
        
        view.addSubview(timerPauseContainer)
        
        
        NSLayoutConstraint.activate([
            timerPauseContainer.topAnchor.constraint(equalTo: view.topAnchor),
            timerPauseContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerPauseContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerPauseContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(stopContainer)
        
        NSLayoutConstraint.activate([
            stopContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            stopContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stopContainer.widthAnchor.constraint(equalToConstant: 44),
            stopContainer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(iconStop)
        
        NSLayoutConstraint.activate([
            iconStop.centerXAnchor.constraint(equalTo: stopContainer.centerXAnchor),
            iconStop.centerYAnchor.constraint(equalTo: stopContainer.centerYAnchor),
            iconStop.widthAnchor.constraint(equalToConstant: 20),
            iconStop.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(iconCancel)
        
        NSLayoutConstraint.activate([
            iconCancel.centerXAnchor.constraint(equalTo: stopContainer.centerXAnchor),
            iconCancel.centerYAnchor.constraint(equalTo: stopContainer.centerYAnchor),
            iconCancel.widthAnchor.constraint(equalToConstant: 18),
            iconCancel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        view.addSubview(mainBg)
        
        NSLayoutConstraint.activate([
            mainBg.topAnchor.constraint(equalTo: view.topAnchor),
            mainBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(swipeUpIcon)
        
        NSLayoutConstraint.activate([
            swipeUpIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -108),
            swipeUpIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeUpIcon.widthAnchor.constraint(equalToConstant: 20),
            swipeUpIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(swipeUpLabel)
        
        NSLayoutConstraint.activate([
            swipeUpLabel.topAnchor.constraint(equalTo: swipeUpIcon.bottomAnchor, constant: 4),
            swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(timerShownContainer)
        
        NSLayoutConstraint.activate([
            timerShownContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            timerShownContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerShownContainer.widthAnchor.constraint(equalToConstant: 136),
            timerShownContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        timerShownContainer.addSubview(hideTimerIcon)
        
        NSLayoutConstraint.activate([
            hideTimerIcon.topAnchor.constraint(equalTo: timerShownContainer.topAnchor, constant: 16),
            hideTimerIcon.trailingAnchor.constraint(equalTo: timerShownContainer.trailingAnchor, constant: -16),
            hideTimerIcon.widthAnchor.constraint(equalToConstant: 25),
            hideTimerIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        timerLabel.text = "00:00"
        timerShownContainer.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: timerShownContainer.topAnchor, constant: 13),
            timerLabel.leadingAnchor.constraint(equalTo: timerShownContainer.leadingAnchor, constant: 16),
        ])
        
        view.addSubview(infoEndSession)
        
        NSLayoutConstraint.activate([
            infoEndSession.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 41),
            infoEndSession.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoEndSession.widthAnchor.constraint(equalToConstant: 335),
            infoEndSession.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        infoEndSession.addSubview(infoEndSessionIcon)
        
        NSLayoutConstraint.activate([
            infoEndSessionIcon.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor),
            infoEndSessionIcon.leadingAnchor.constraint(equalTo: infoEndSession.leadingAnchor, constant: 22),
            infoEndSessionIcon.widthAnchor.constraint(equalToConstant: 28),
            infoEndSessionIcon.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        infoEndSession.addSubview(infoEndSessionLabel)
        
        NSLayoutConstraint.activate([
            infoEndSessionLabel.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor),
            infoEndSessionLabel.leadingAnchor.constraint(equalTo: infoEndSessionIcon.trailingAnchor, constant: 17),
            infoEndSessionLabel.widthAnchor.constraint(equalToConstant: 231),
            infoEndSessionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        infoEndSession.addSubview(infoPodomoro)
        
        NSLayoutConstraint.activate([
            infoPodomoro.centerXAnchor.constraint(equalTo: infoEndSession.centerXAnchor),
            infoPodomoro.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor)
        ])
        
        view.addSubview(bgInputTask)
        
        NSLayoutConstraint.activate([
            bgInputTask.topAnchor.constraint(equalTo: view.topAnchor),
            bgInputTask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgInputTask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgInputTask.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(containerInputTask)
        
        NSLayoutConstraint.activate([
            containerInputTask.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerInputTask.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerInputTask.widthAnchor.constraint(equalToConstant: 322),
            containerInputTask.heightAnchor.constraint(equalToConstant: 235)
        ])
        
        containerInputTask.addSubview(inputTaskTitle)
        
        NSLayoutConstraint.activate([
            inputTaskTitle.topAnchor.constraint(equalTo: containerInputTask.topAnchor, constant: 25),
            inputTaskTitle.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor),
            inputTaskTitle.widthAnchor.constraint(equalToConstant: 239),
            inputTaskTitle.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        containerInputTask.addSubview(inputTaskTextField)
        
        NSLayoutConstraint.activate([
            inputTaskTextField.topAnchor.constraint(equalTo: inputTaskTitle.bottomAnchor, constant: 13),
            inputTaskTextField.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor),
            inputTaskTextField.widthAnchor.constraint(equalToConstant: 259),
            inputTaskTextField.heightAnchor.constraint(equalToConstant: 43)
        ])
        
        containerInputTask.addSubview(inputTaskBtn)
        
        NSLayoutConstraint.activate([
            inputTaskBtn.topAnchor.constraint(equalTo: inputTaskTextField.bottomAnchor, constant: 29),
            inputTaskBtn.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor)
        ])
        
        view.addSubview(alertOnFocus)
        
        NSLayoutConstraint.activate([
            alertOnFocus.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 36),
            alertOnFocus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertOnFocus.widthAnchor.constraint(equalToConstant: 321),
            alertOnFocus.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(alertOnPodomoro)
        
        NSLayoutConstraint.activate([
            alertOnPodomoro.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 36),
            alertOnPodomoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertOnPodomoro.widthAnchor.constraint(equalToConstant: 321),
            alertOnPodomoro.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
            UIView.animate(withDuration: 0.5, animations: {
                self.alertOnFocus.removeFromSuperview()
            }, completion: { done in
                
                if done{
                    self.alertOnPodomoro.alpha = 1.0
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                        UIView.animate(withDuration: 0.5, animations: {
                            self.alertOnPodomoro.removeFromSuperview()
                        })
                    }
                }
                
            })
        }
        
        
        // Create and start the timer
        startTimer()
        
        
        startMotionUpdates()
        prepareHaptic()
        
        // Create a swipe gesture recognizer
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeGestureDown.direction = .down
        view.addGestureRecognizer(swipeGestureDown)
        
        iconCancel.addTarget(self, action: #selector(cancelEndFocus), for: .touchUpInside)
        
        iconStop.addTarget(self, action: #selector(stopBtnFocus), for: .touchUpInside)
        
        let btnFinishGesture = UITapGestureRecognizer(target: self, action: #selector(btnFinish))
        btnContinue.isUserInteractionEnabled = true
        btnContinue.addGestureRecognizer(btnFinishGesture)
        
        let btnBackGesture = UITapGestureRecognizer(target: self, action: #selector(btnHome))
        btnBackHome.isUserInteractionEnabled = true
        btnBackHome.addGestureRecognizer(btnBackGesture)
        
        hideTimer.addTarget(self, action: #selector(showTimer), for: .touchUpInside)
        hideTimerIcon.addTarget(self, action: #selector(timerHide), for: .touchUpInside)
        
        inputTaskBtn.addTarget(self, action: #selector(continueResult), for: .touchUpInside)
        
        checkMinimumBadge(timerStart)
        
        animatePause()
        checkRaisePhone()
        
    }

    
    func checkRaisePhone(){
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.2 // Interval pengambilan data dalam detik
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                if let acceleration = data?.acceleration {
                    // Di sini Anda dapat memeriksa data percepatan untuk mengidentifikasi gerakan perangkat.
                    // Anda dapat menggunakan nilai-nilai percepatan untuk menentukan apakah perangkat sedang diangkat atau tidak.
                    let totalAcceleration = sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
                    let threshold = 1.0 // Nilai ambang dapat disesuaikan sesuai kebutuhan
                    
                    if totalAcceleration > threshold {
                        self.swipeUpLabel.alpha = 1.0
                        self.swipeUpIcon.alpha = 1.0
                     
                        DispatchQueue.main.asyncAfter(deadline: .now()+5.0){
                            self.swipeUpLabel.alpha = 0.0
                            self.swipeUpIcon.alpha = 0.0
                        }
                    } else {
                        print("tidak di angkat")
                    }
                }
            }
        }
        
    }
    
    func animatePause() {
        UIView.animate(withDuration: 1, animations: {
            self.swipeUpIcon.transform = CGAffineTransform(translationX: 0, y: -8)
        }, completion: { done in
            if done {
                self.loopAnimate()
            }
        })
    }
    
    func loopAnimate() {
        UIView.animate(withDuration: 1, animations: {
            self.swipeUpIcon.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { done in
            if done {
                self.animatePause()
            }
        })
    }
    
    func checkMinimumBadge(_ timer: Int){
        
        if timerStart > 1200{
            endFocus.contentLabel.text = "Finish to see what you've caught!"
        }else{
            let theBareMinimum = 1200 - timerStart
            
            let finalBareTime = minuteToString(time: TimeInterval(theBareMinimum))
            
            endFocus.contentLabel.text = "Continue for another \(finalBareTime) minutes to get fish or nothing at all"
        }
        
        
        
    }
    
    func minuteToString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        
        return String(format: "%02i", minute)
    }
    
    @objc func continueResult(){
        guard let text = inputTaskTextField.text, !text.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in the text field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        let myUserDefault = UserDefaults.standard
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let dateString = dateFormatter.string(from: currentDate)
        gachaSytem.gachaPull()
        let setFish = gachaSytem.setFish
        let setRarerity = gachaSytem.setRarerity
        
        let newData: [String: String] = [
            "date": dateString,
            "time": "\(minuteToString(time: TimeInterval(timerStart)))",
            "activity": text,
            "fish": setFish,
            "rarerity": setRarerity
        ]
        
        var existingData: [[String: String]]
        
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            existingData = decodedData
        } else {
            existingData = []
        }
        
        existingData.append(newData)
        
        if let encodedData = try? JSONEncoder().encode(existingData) {
            myUserDefault.set(encodedData, forKey: "focusData")
        }
        
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            for dictionary in decodedData {
                for (key, value) in dictionary {
                    print("Key: \(key), Value: \(value)")
                }
            }
        } else {
            print("No data found in UserDefaults for the key 'focusData'")
        }
        
        
        let vc = ResultViewController(time: minuteToString(time: TimeInterval(timerStart)), activity: text, fish: setFish, rare: setRarerity)
        gachaSytem.reset()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func timerHide(){
        UIView.animate(withDuration: 0.5, animations: {
            self.hideIcon.alpha = 1.0
            self.hideTimer.alpha = 1.0
            self.timerLabel.alpha = 0.0
            self.timerShownContainer.alpha = 0.0
            self.hideTimerIcon.alpha = 0.0
        })
    }
    
    @objc func showTimer(){
        UIView.animate(withDuration: 0.5, animations: {
            self.hideIcon.alpha = 0.0
            self.hideTimer.alpha = 0.0
            self.timerLabel.alpha = 1.0
            self.timerShownContainer.alpha = 1.0
            self.hideTimerIcon.alpha = 1.0
        })
    }
    
    func changeShowInfo() {
        showInfo.toggle()
        
        if showInfo{
            UIView.animate(withDuration: 0.5, animations: {
                self.infoLabel.alpha = 1.0
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.infoLabel.alpha = 0.0
            })
        }
    }
    
    @objc func guideTapGesture(gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        UIView.animate(withDuration: 0.5, animations: {
            currentView.removeFromSuperview()
        })
        
        if let recog = view.gestureRecognizers{
            for recognizer in recog {
                recognizer.isEnabled = false
            }
        }
        
        let nextIndex = (userGuideInfo.firstIndex(of: currentView as! ReuseableInfoView) ?? 0 )+1
        
        if nextIndex < userGuideInfo.count{
            let nextView = userGuideInfo[nextIndex]
            
            switch nextIndex{
            case 2:
                self.timerLabel.layer.zPosition = 15
                self.timerShownContainer.layer.zPosition = 15
                self.hideTimerIcon.layer.zPosition = 15
                break
            case 3:
                timerPauseContainer.layer.zPosition = 15
                if timerPauseContainer.totalPauseTimer <= 0{
                    UIView.animate(withDuration: 0.5, animations: {
                        self.breakExhausted.alpha = 1.0
                    })
                }else{
                    UIView.animate(withDuration: 0.4, animations: {
                        self.timerPauseContainer.alpha = 1.0
                        self.iconStop.alpha = 0.0
                        self.stopContainer.alpha = 0.0
                        self.mainBg.image = UIImage(named: "bg-pause")
                        self.swipeUpIcon.image = UIImage(named: "icon-down")
                        self.swipeUpLabel.text = "Resume"
                        self.hideIcon.alpha = 0.0
                        self.hideTimer.alpha = 0.0
                        self.timerLabel.alpha = 0.0
                        self.timerShownContainer.alpha = 0.0
                        self.hideTimerIcon.alpha = 0.0
                    })
                    
                    if timer != nil {
                        timer?.invalidate()
                        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
                    }
                }
                break
            case 5:
                UIView.animate(withDuration: 0.4, animations: {
                    self.timerPauseContainer.alpha = 0.0
                    self.iconStop.alpha = 1.0
                    self.infoLabel.alpha = 0.0
                    self.stopContainer.alpha = 1.0
                    self.mainBg.image = UIImage(named: "bg-latest")
                    self.swipeUpIcon.image = UIImage(named: "icon-up")
                    self.swipeUpLabel.text = "Pause"
                    self.hideIcon.alpha = 0.0
                    self.hideTimer.alpha = 0.0
                    self.timerLabel.alpha = 1.0
                    self.timerShownContainer.alpha = 1.0
                    self.hideTimerIcon.alpha = 1.0
                    self.infoEndSession.alpha = 1.0
                    self.infoPodomoro.alpha = 1.0
                    self.infoEndSession.layer.zPosition = 15
                    self.infoPodomoro.layer.zPosition = 15
                })
                if timer != nil {
                    timer?.invalidate()
                    startTimer()
                }
                break
            case 8:
                
                break
                
            default:
                break
            }
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
            nextView.addGestureRecognizer(gesture)
            
            nextView.layer.zPosition = 12
            UIView.animate(withDuration: 0.5, animations: {
                self.view.addSubview(nextView)
            })
            
            NSLayoutConstraint.activate([
                nextView.topAnchor.constraint(equalTo: view.topAnchor),
                nextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                nextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                nextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            
        }
    }
    
    
    @objc func btnFinish(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        UIView.animate(withDuration: 0.5, animations: {
            self.bgInputTask.alpha = 0.5
            self.containerInputTask.alpha = 1.0
            self.inputTaskBtn.alpha = 1.0
            self.inputTaskTitle.alpha = 1.0
            self.inputTaskTextField.alpha = 1.0
            self.btnContinue.alpha = 0.0
            self.endFocus.alpha = 0.0
            self.inputTaskTitle.text = "What task you have been working on for the last \(self.minuteToString(time: TimeInterval(self.timerStart))) minutes?"
            self.hideIcon.alpha = 0.0
            self.hideTimer.alpha = 0.0
            self.timerLabel.alpha = 0.0
            self.timerShownContainer.alpha = 0.0
            self.hideTimerIcon.alpha = 0.0
            self.iconCancel.alpha = 0.0
            self.stopContainer.alpha = 0.0
        })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func btnHome(){
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func stopBtnFocus(){
        UIView.animate(withDuration: 0.5, animations: {
            self.infoEndSession.alpha = 1.0
            self.infoEndSessionIcon.alpha = 1.0
            self.infoEndSessionLabel.alpha = 1.0
            self.infoPodomoro.alpha = 0.0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
            UIView.animate(withDuration: 0.5, animations: {
                self.infoEndSession.alpha = 0.0
                self.infoEndSessionIcon.alpha = 0.0
                self.infoEndSessionLabel.alpha = 0.0
            })
        }
    }
    
    @objc func cancelEndFocus(){
        if let recog = view.gestureRecognizers{
            for recognizer in recog {
                recognizer.isEnabled = true
            }
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.endFocus.alpha = 0.0
            self.iconStop.alpha = 1.0
            self.iconCancel.alpha = 0.0
            self.btnContinue.alpha = 0.0
            self.startTimer()
        })
    }
    
    @objc func handleSwipeDown(_ gesture : UISwipeGestureRecognizer){
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.4, animations: {
                self.timerPauseContainer.alpha = 0.0
                self.iconStop.alpha = 1.0
                self.infoLabel.alpha = 0.0
                self.stopContainer.alpha = 1.0
                self.mainBg.image = UIImage(named: "bg-latest")
                self.swipeUpIcon.image = UIImage(named: "icon-up")
                self.swipeUpLabel.text = "Pause"
                self.hideIcon.alpha = 0.0
                self.hideTimer.alpha = 0.0
                self.timerLabel.alpha = 1.0
                self.timerShownContainer.alpha = 1.0
                self.hideTimerIcon.alpha = 1.0
            })
            if timer != nil {
                timer?.invalidate()
                startTimer()
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updatePauseTimerLabel(){
        
        if timerPauseContainer.totalPauseTimer <= 0{
            UIView.animate(withDuration: 0.5, animations: {
                self.breakExhausted.alpha = 1.0
                self.timerPauseContainer.alpha = 0.0
                self.iconStop.alpha = 1.0
                self.infoLabel.alpha = 0.0
                self.stopContainer.alpha = 1.0
                self.mainBg.image = UIImage(named: "bg-latest")
                self.swipeUpIcon.image = UIImage(named: "icon-up")
                self.swipeUpLabel.text = "Pause"
                self.hideIcon.alpha = 1.0
                self.hideTimer.alpha = 1.0
            })
        }else{
            timerPauseContainer.updatePauseTimer()
        }
        
    }
    
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            complexSuccess()
            
            
            if timerPauseContainer.totalPauseTimer <= 0{
                UIView.animate(withDuration: 0.5, animations: {
                    self.breakExhausted.alpha = 1.0
                })
            }else{
                UIView.animate(withDuration: 0.4, animations: {
                    self.timerPauseContainer.alpha = 1.0
                    self.iconStop.alpha = 0.0
                    self.stopContainer.alpha = 0.0
                    self.mainBg.image = UIImage(named: "bg-pause")
                    self.swipeUpIcon.image = UIImage(named: "icon-down")
                    self.swipeUpLabel.text = "Resume"
                    self.hideIcon.alpha = 0.0
                    self.hideTimer.alpha = 0.0
                    self.timerLabel.alpha = 0.0
                    self.timerShownContainer.alpha = 0.0
                    self.hideTimerIcon.alpha = 0.0
                })
                
                if timer != nil {
                    timer?.invalidate()
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
                }
            }
            
            
            
        }
    }
    
    @objc func updateTimerLabel() {
        // Update the timer label with the current time
        timerStart += 1
        podomoroTime += 1
        
        if podomoroTime == 1500{
            
            if podomoroStep == 1{
                UIView.animate(withDuration: 0.5, animations: {
                    self.podomoroAlerts.alpha = 1.0
                })
                
                podomoroTime = 0
                podomoroStep += 1
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.infoPodomoro.alpha = 1.0
                    self.infoEndSession.alpha = 1.0
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
                    UIView.animate(withDuration: 0.5, animations: {
                        self.infoPodomoro.alpha = 0.0
                        self.infoEndSession.alpha = 0.0
                    })
                }
                timerPauseContainer.totalPauseTimer += 300
                podomoroTime = 0
                podomoroStep += 1
            }
            
        }
        
        let currentTime = timerToString(time: TimeInterval(timerStart))
        print(currentTime)
        timerLabel.text = currentTime
        
    }
    
    func timerToString(time: TimeInterval) -> String
    {
        let minute = Int(time) / 60
        let second = Int(time) % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motionData, error) in
                guard let motionData = motionData else { return }
                if self?.isShaking(motionData) == true {
                    self?.complexSuccess()
                    self?.stopTimer()
                }
            }
        }
    }
    
    func isShaking(_ motionData: CMDeviceMotion) -> Bool {
        
        let acceleration = motionData.userAcceleration
        let totalAcceleration = sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
        return totalAcceleration >= motionThreshold
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            self.checkMinimumBadge(timerStart)
            
            if let recog = view.gestureRecognizers{
                for recognizer in recog {
                    recognizer.isEnabled = false
                }
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                self.endFocus.alpha = 1.0
                self.iconStop.alpha = 0.0
                self.iconCancel.alpha = 1.0
                self.timerPauseContainer.alpha = 0.0
                self.infoLabel.alpha = 0.0
                self.btnContinue.alpha = 1.0
            })
        }
    }
    
    func showStopTimerAlert() {
        let alertController = UIAlertController(title: "Timer Stopped", message: "Shake detected", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { [weak self] _ in
            // Restart the timer when the user chooses to dismiss
            self?.startTimer()
        }
        
        alertController.addAction(okAction)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
    
    func prepareHaptic(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch{
            print("Your device not support haptic: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness =  CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event =  CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        events.append(event)
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("fail \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the timer when the view disappears
        UIApplication.shared.isIdleTimerDisabled = false
        motionManager.stopAccelerometerUpdates()
        timer?.invalidate()
    }
    
    
}

