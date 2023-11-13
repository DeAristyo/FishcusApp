//
//  FocusViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 17/10/23.
//

import UIKit
import CoreMotion
import AVFoundation
import UserNotifications

class FocusViewController: UIViewController, DelegateProtocol, UITextFieldDelegate  {
    
    //Service Class
    let gachaSytem = GachaSystem()
    let countDownTimer = CountdownRingView()
    let notificationService = NotificationServices()
    
    //Video layer background separate
    var fokusLayer: AVPlayerLayer?
    var fokus: AVPlayer?
    var reelLayer: AVPlayerLayer?
    var reel: AVPlayer?
    var pauseLayer: AVPlayerLayer?
    var pause: AVPlayer?
    var myUserDefault = UserDefaults.standard
    
    //Timer
    var timer: Timer?
    var timerStart: Int = 1200
    
    //show info toggle to show more info in pause mode
    var showInfo = false
    
    
    //var to check step in on boarding first time user
    var infoStep = 0 {
        didSet{
            if infoStep == 6 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.infoEndSession.alpha = 1.0
                    self.infoEndSessionLabel.alpha = 1.0
                    self.infoEndSessionIcon.alpha = 1.0
                    self.infoPodomoro.alpha = 0.0
                    self.infoEndSession.layer.zPosition = 15
                    self.infoEndSessionIcon.layer.zPosition = 15
                    self.infoEndSessionLabel.layer.zPosition = 15
                    self.infoPodomoro.layer.zPosition = 12
                })
                
                self.view.addSubview(infoEndFocus)
                
                infoEndFocus.layer.zPosition = 12
                
                NSLayoutConstraint.activate([
                    infoEndFocus.topAnchor.constraint(equalTo: view.topAnchor),
                    infoEndFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    infoEndFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    infoEndFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
        }
    }
    
    //Podomoro system
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
    
    
    //Motion Manager
    let motionManager = CMMotionManager()
    let motionService = CoreMotionService()
    
    
    private var mainBg: UIImageView = {
        let fishing =  UIImageView()
        fishing.image = UIImage(named: "bg-latest")
        fishing.contentMode = .scaleAspectFill
        fishing.layer.zPosition = 1
        fishing.translatesAutoresizingMaskIntoConstraints = false
        
        return fishing
    }()
    
    //task monik
    var videoBgFocus: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var tempFocus: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var videoBgReel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var tempReel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var videoBgPause: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var tempPause: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var iconStop: UIButton = {
        let stop = UIButton(type: .custom)
        stop.setImage(UIImage(named: "icon-stop"), for: .normal)
        stop.contentMode = .scaleAspectFill
        stop.layer.zPosition = 12
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
        view.layer.zPosition = 12
        view.layer.cornerRadius = view.frame.size.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var userGuideInfo: [ReuseableInfoView] = [
        ReuseableInfoView(bgStyle: .type2, mascotIcon: .mascot3, labelText: "“Let’s start fishing! During Focus session, you can start focusing on your tasks and...", position: false, labelTextStyle: .label3),
        ReuseableInfoView(bgStyle: .type2, mascotIcon: .mascot3, labelText: "“If you need to go out of the app or simply just want to take a break, you can pause by swiping up the Home button on your phone!”", position: false, labelTextStyle: .label3),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot2, labelText: "“You can make the timer visible or invisible as you like. It's up to you.”", position: false, labelTextStyle: .label7),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot4, labelText: "“You only have 10 minutes of break! If you have reached the time limit, you can’t pause anymore. So use your time wisely!”", position: false, labelTextStyle: .label4),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot5, labelText: "\"If you have questions or need more details, click the ‘ ‘ button for more information.\"", position: false, labelTextStyle: .label8),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot6, labelText: "“Earn 5 minutes of break time for every 20 minutes of productive focus. The more you focus, the more break time you'll receive.”", position: false, labelTextStyle: .label9)
    ]
    
    private var infoEndFocus = ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot1, labelText: "\"Finished studying? End your focus mode by lifting your cellphone like you're pulling in a fishing rod.\"", position: false, labelTextStyle: .label10)
    private var infoInputTask = ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot2, labelText: "“Ready to spill the study tea? Time to input your study milestones. We're crafting your own study map to discover your progress.”", position: false, labelTextStyle: .label11)
    
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
        let view = OnFocusAlerts(icon: .icon2, labelInfo: "You’ll get +5 mins break for every 20 minutes study.")
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var backgroundOverlay: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.clipsToBounds = true
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.backgroundColor = UIColor.white.cgColor
        view.alpha = 0.5
        view.addSubview(blurEffectView)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        // View Configuration
        SetupDelegate()
        SetupAlpha()
        SetupView()
        SetupOnBoarding()
        SetupConstraint()
        
        // Gesture config
        SetupGesture()
        
        // Start track motion
        startMotionUpdates()
        
        // Check min condition to get fish
        checkMinimumBadge(timerStart)
        
        // start animated to pause/resume swipe button
        animatePause()
        
        // check phone raise or not
        checkRaisePhone()
        
        // Setup background Video
        SetupBackgroundLayerVideo()
        playVideoFocus()
        
        //App lifecycle
        AppLifeCycle()
        
    }
    
    /// Life Cycle Action
    func AppLifeCycle(){
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(inBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    /// in background run
    @objc func inBackground(){
        notificationService.pushNotification()
    }
    
    /// from background and active again
    @objc func becomeActive(){
        playVideoFocus()
    }
    
    
    /// func start with Setup is related to view coniguration to viewdidload
    func SetupAlpha(){
        breakExhausted.alpha = 0.0
        podomoroAlerts.alpha = 0.0
        timerPauseContainer.alpha = 0.0
        endFocus.alpha = 0.0
        iconCancel.alpha = 0.0
        infoLabel.alpha = 0.0
        btnContinue.alpha = 0.0
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
        alertOnPodomoro.alpha = 0.0
        swipeUpIcon.alpha = 0.0
        swipeUpLabel.alpha = 0.0
        infoInputTask.alpha = 0.0
        videoBgReel.alpha = 0.0
        tempReel.alpha = 0.0
        videoBgPause.alpha = 0.0
        tempPause.alpha = 0.0
        alertOnFocus.alpha = 0.0
    }
    
    func SetupDelegate(){
        inputTaskTextField.delegate =  self
        timerPauseContainer.delegate = self
        breakExhausted.delegate = self
        podomoroAlerts.delegate = self
    }
    
    func SetupView(){
        view.addSubview(videoBgFocus)
        view.addSubview(tempFocus)
        view.addSubview(videoBgReel)
        view.addSubview(tempReel)
        view.addSubview(videoBgPause)
        view.addSubview(tempPause)
        view.addSubview(breakExhausted)
        view.addSubview(podomoroAlerts)
        view.addSubview(hideTimer)
        hideTimer.addSubview(hideIcon)
        view.addSubview(infoLabel)
        view.addSubview(endFocus)
        view.addSubview(btnContinue)
        view.addSubview(timerPauseContainer)
        view.addSubview(stopContainer)
        view.addSubview(iconStop)
        view.addSubview(iconCancel)
        view.addSubview(swipeUpIcon)
        view.addSubview(swipeUpLabel)
        view.addSubview(timerShownContainer)
        timerShownContainer.addSubview(hideTimerIcon)
        timerLabel.text = "00:00"
        timerShownContainer.addSubview(timerLabel)
        view.addSubview(infoEndSession)
        infoEndSession.addSubview(infoEndSessionIcon)
        infoEndSession.addSubview(infoEndSessionLabel)
        infoEndSession.addSubview(infoPodomoro)
        view.addSubview(bgInputTask)
        view.addSubview(containerInputTask)
        containerInputTask.addSubview(inputTaskTitle)
        containerInputTask.addSubview(inputTaskTextField)
        containerInputTask.addSubview(inputTaskBtn)
        view.addSubview(alertOnFocus)
        view.addSubview(alertOnPodomoro)
        view.addSubview(infoInputTask)
        infoInputTask.layer.zPosition = 12
    }
    
    func SetupConstraint(){
        NSLayoutConstraint.activate([
            breakExhausted.topAnchor.constraint(equalTo: view.topAnchor),
            breakExhausted.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breakExhausted.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breakExhausted.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            podomoroAlerts.topAnchor.constraint(equalTo: view.topAnchor),
            podomoroAlerts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            podomoroAlerts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            podomoroAlerts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hideTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            hideTimer.widthAnchor.constraint(equalToConstant: 44),
            hideTimer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            hideIcon.centerXAnchor.constraint(equalTo: hideTimer.centerXAnchor),
            hideIcon.centerYAnchor.constraint(equalTo: hideTimer.centerYAnchor, constant: 2),
            hideIcon.widthAnchor.constraint(equalToConstant: 23),
            hideIcon.heightAnchor.constraint(equalToConstant: 9)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.widthAnchor.constraint(equalToConstant: 298),
            infoLabel.heightAnchor.constraint(equalToConstant: 143)
        ])
        
        NSLayoutConstraint.activate([
            endFocus.topAnchor.constraint(equalTo: view.topAnchor),
            endFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            endFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            btnContinue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContinue.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80)
        ])
        
        NSLayoutConstraint.activate([
            timerPauseContainer.topAnchor.constraint(equalTo: view.topAnchor),
            timerPauseContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerPauseContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerPauseContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stopContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            stopContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stopContainer.widthAnchor.constraint(equalToConstant: 44),
            stopContainer.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            iconStop.centerXAnchor.constraint(equalTo: stopContainer.centerXAnchor),
            iconStop.centerYAnchor.constraint(equalTo: stopContainer.centerYAnchor),
            iconStop.widthAnchor.constraint(equalToConstant: 20),
            iconStop.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            iconCancel.centerXAnchor.constraint(equalTo: stopContainer.centerXAnchor),
            iconCancel.centerYAnchor.constraint(equalTo: stopContainer.centerYAnchor),
            iconCancel.widthAnchor.constraint(equalToConstant: 18),
            iconCancel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            swipeUpIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -108),
            swipeUpIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeUpIcon.widthAnchor.constraint(equalToConstant: 20),
            swipeUpIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            swipeUpLabel.topAnchor.constraint(equalTo: swipeUpIcon.bottomAnchor, constant: 4),
            swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            timerShownContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            timerShownContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerShownContainer.widthAnchor.constraint(equalToConstant: 136),
            timerShownContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            hideTimerIcon.topAnchor.constraint(equalTo: timerShownContainer.topAnchor, constant: 16),
            hideTimerIcon.trailingAnchor.constraint(equalTo: timerShownContainer.trailingAnchor, constant: -16),
            hideTimerIcon.widthAnchor.constraint(equalToConstant: 25),
            hideTimerIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: timerShownContainer.topAnchor, constant: 13),
            timerLabel.leadingAnchor.constraint(equalTo: timerShownContainer.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            infoEndSession.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 41),
            infoEndSession.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoEndSession.widthAnchor.constraint(equalToConstant: 335),
            infoEndSession.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            infoEndSessionIcon.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor),
            infoEndSessionIcon.leadingAnchor.constraint(equalTo: infoEndSession.leadingAnchor, constant: 22),
            infoEndSessionIcon.widthAnchor.constraint(equalToConstant: 28),
            infoEndSessionIcon.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
        
        NSLayoutConstraint.activate([
            infoEndSessionLabel.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor),
            infoEndSessionLabel.leadingAnchor.constraint(equalTo: infoEndSessionIcon.trailingAnchor, constant: 17),
            infoEndSessionLabel.widthAnchor.constraint(equalToConstant: 231),
            infoEndSessionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            infoPodomoro.centerXAnchor.constraint(equalTo: infoEndSession.centerXAnchor),
            infoPodomoro.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bgInputTask.topAnchor.constraint(equalTo: view.topAnchor),
            bgInputTask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgInputTask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgInputTask.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerInputTask.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerInputTask.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerInputTask.widthAnchor.constraint(equalToConstant: 322),
            containerInputTask.heightAnchor.constraint(equalToConstant: 235)
        ])
        
        NSLayoutConstraint.activate([
            inputTaskTitle.topAnchor.constraint(equalTo: containerInputTask.topAnchor, constant: 25),
            inputTaskTitle.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor),
            inputTaskTitle.widthAnchor.constraint(equalToConstant: 239),
            inputTaskTitle.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            inputTaskTextField.topAnchor.constraint(equalTo: inputTaskTitle.bottomAnchor, constant: 13),
            inputTaskTextField.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor),
            inputTaskTextField.widthAnchor.constraint(equalToConstant: 259),
            inputTaskTextField.heightAnchor.constraint(equalToConstant: 43)
        ])
        
        NSLayoutConstraint.activate([
            inputTaskBtn.topAnchor.constraint(equalTo: inputTaskTextField.bottomAnchor, constant: 29),
            inputTaskBtn.centerXAnchor.constraint(equalTo: containerInputTask.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alertOnFocus.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 36),
            alertOnFocus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertOnFocus.widthAnchor.constraint(equalToConstant: 321),
            alertOnFocus.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            alertOnPodomoro.topAnchor.constraint(equalTo: hideTimer.bottomAnchor, constant: 36),
            alertOnPodomoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertOnPodomoro.widthAnchor.constraint(equalToConstant: 321),
            alertOnPodomoro.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            infoInputTask.topAnchor.constraint(equalTo: view.topAnchor),
            infoInputTask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoInputTask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoInputTask.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func SetupOnBoarding(){
        if ((myUserDefault.data(forKey: "focusData")?.isEmpty) == nil){
            startTimer()
            alertOnFocus.alpha = 0.0
            
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
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            view.addSubview(blurEffectView)
            
            view.addSubview(countDownTimer)
            countDownTimer.translatesAutoresizingMaskIntoConstraints = false
            countDownTimer.layer.zPosition = 12
            countDownTimer.transform = CGAffineTransform(rotationAngle: -90 * .pi / 180.0)
            
            
            NSLayoutConstraint.activate([
                countDownTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                countDownTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            countDownTimer.startCountdown()
            DispatchQueue.main.asyncAfter(deadline: .now()+3.5){
                // Create and start the timer
                self.startTimer()
                if((self.myUserDefault.data(forKey: "focusData")?.isEmpty) != nil){
                    UIView.animate(withDuration: 0.5, animations: {
                        self.alertOnFocus.alpha = 1.0
                    })
                }
                blurEffectView.removeFromSuperview()
                self.countDownTimer.removeFromSuperview()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 9.0){
                UIView.animate(withDuration: 0.5, animations: {
                    self.alertOnFocus.removeFromSuperview()
                }, completion: { done in
                    
                    if done{
                        UIView.animate(withDuration: 0.5, animations: {
                            self.alertOnPodomoro.alpha = 1.0
                        })
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                            UIView.animate(withDuration: 0.5, animations: {
                                self.alertOnPodomoro.removeFromSuperview()
                            })
                        }
                    }
                    
                })
            }
            
            //            swipeUpIcon.alpha = 1.0
            //            swipeUpLabel.alpha = 1.0
        }
    }
    
    func SetupGesture(){
        // Create a swipe gesture recognizer
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeGestureDown.direction = .down
        view.addGestureRecognizer(swipeGestureDown)
        
        let tapGestureLastInfo = UITapGestureRecognizer(target: self, action: #selector(lastInfo))
        infoInputTask.isUserInteractionEnabled = true
        infoInputTask.addGestureRecognizer(tapGestureLastInfo)
        
        iconCancel.addTarget(self, action: #selector(cancelEndFocus), for: .touchUpInside)
        
        iconStop.addTarget(self, action: #selector(stopBtnFocus), for: .touchUpInside)
        
        let btnFinishGesture = UITapGestureRecognizer(target: self, action: #selector(btnFinish))
        btnContinue.isUserInteractionEnabled = true
        btnContinue.addGestureRecognizer(btnFinishGesture)
        
        hideTimer.addTarget(self, action: #selector(showTimer), for: .touchUpInside)
        hideTimerIcon.addTarget(self, action: #selector(timerHide), for: .touchUpInside)
        
        inputTaskBtn.addTarget(self, action: #selector(continueResult), for: .touchUpInside)
    }
    
    
    /// podomoro system
    func dismissBreakExhausted() {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            self.breakExhausted.alpha = 0.0
            self.timer?.invalidate()
            startTimer()
        })
    }
    
    func takePodomoroAlert() {
        timerPauseContainer.totalPauseTimer += 300
       
        UIView.animate(withDuration: 0.5, animations: {
            self.podomoroAlerts.alpha = 0.0
        })
        
        SwipeUpAction()
        
    }
    
    func continuePodomoroAlert() {
        timerPauseContainer.totalPauseTimer += 300
        UIView.animate(withDuration: 0.5, animations: {
            self.podomoroAlerts.alpha = 0.0
        })
    }
    
    
    /// Setup Video Layer as Background
    func SetupBackgroundLayerVideo(){
        guard let pathFocus = Bundle.main.path(forResource: "FocusModeAnimation", ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        guard let pathReel = Bundle.main.path(forResource: "ReelingAnimation", ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        guard let pathPause = Bundle.main.path(forResource: "PauseModeAnimation", ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        fokus = AVPlayer(url: URL(fileURLWithPath: pathFocus))
        fokusLayer = AVPlayerLayer(player: fokus)
        fokusLayer?.frame = self.view.bounds
        fokusLayer?.videoGravity = .resizeAspectFill
        self.videoBgFocus.layer.addSublayer(fokusLayer!)
        self.tempFocus.layer.addSublayer(fokusLayer!)
        
        reel = AVPlayer(url: URL(fileURLWithPath: pathReel))
        reelLayer = AVPlayerLayer(player: reel)
        reelLayer?.frame = self.view.bounds
        reelLayer?.videoGravity = .resizeAspectFill
        self.videoBgReel.layer.addSublayer(reelLayer!)
        self.tempReel.layer.addSublayer(reelLayer!)
        
        pause = AVPlayer(url: URL(fileURLWithPath: pathPause))
        pauseLayer = AVPlayerLayer(player: pause)
        pauseLayer?.frame = self.view.bounds
        pauseLayer?.videoGravity = .resizeAspectFill
        self.videoBgPause.layer.addSublayer(pauseLayer!)
        self.tempPause.layer.addSublayer(pauseLayer!)
    }
    
    
    func playReelingAnimation() {
        if let currentItem = reel?.currentItem {
            currentItem.seek(to: CMTime.zero, completionHandler: nil)
        }
        reel?.play()
    }
    
    func playVideoFocus() {
        fokus?.play()
        // Observe the AVPlayer's currentItem status and timeControlStatus
        fokus?.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
        fokus?.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options: [.new], context: nil)
    }
    
    func playVideoPause(){
        pause?.play()
        // Observe the AVPlayer's currentItem status and timeControlStatus
        pause?.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
        pause?.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options: [.new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            if let statusNumber = change?[.newKey] as? NSNumber, let status = AVPlayer.Status(rawValue: statusNumber.intValue) {
                if status == .readyToPlay {
                    // Video is ready to play
                    fokus?.play()
                }
            }
        } else if keyPath == #keyPath(AVPlayer.timeControlStatus) {
            if let timeControlStatusNumber = change?[.newKey] as? NSNumber, let timeControlStatus = AVPlayer.TimeControlStatus(rawValue: timeControlStatusNumber.intValue) {
                if timeControlStatus == .playing {
                    // Video is playing
                } else if timeControlStatus == .paused {
                    // Video is paused
                    if let player = object as? AVPlayer {
                        // Check if the video reached the end
                        if CMTimeCompare(player.currentTime(), player.currentItem!.duration) == 0 {
                            // Seek back to the beginning to loop the video
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                }
            }
        }
    }
    
    
    /// Guided tutorial on boarding Screen
    @objc func guideTapGesture(gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        UIView.animate(withDuration: 0.5, animations: {
            currentView.removeFromSuperview()
        })
        
        inActiveGestureView()
        
        let nextIndex = (userGuideInfo.firstIndex(of: currentView as! ReuseableInfoView) ?? 0 )+1
        
        self.infoStep = nextIndex
        if nextIndex < userGuideInfo.count{
            
            let nextView = userGuideInfo[nextIndex]
            
            switch nextIndex{
            case 2:
                self.timerLabel.layer.zPosition = 15
                self.timerShownContainer.layer.zPosition = 15
                self.hideTimerIcon.layer.zPosition = 15
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
            case 3:
                timerPauseContainer.layer.zPosition = 15
                
                //Animated the pause/resume btn
                animatePause()
                
                // Start pause action
                SwipeUpAction()
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
                
            case 4:
                self.timerLabel.layer.zPosition = 12
                self.timerShownContainer.layer.zPosition = 12
                self.hideTimerIcon.layer.zPosition = 12
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
            case 5:
                animatePause()
                activeGestureView()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.infoEndSession.alpha = 1.0
                    self.infoPodomoro.alpha = 1.0
                    self.infoEndSession.layer.zPosition = 15
                    self.infoPodomoro.layer.zPosition = 15
                })
                
                SwipeDownAction()
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
                
            default:
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
                
            }
            
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
    
    @objc func lastInfo(){
        infoInputTask.removeFromSuperview()
    }
    
    func DidFinishAction(){
        if((self.myUserDefault.data(forKey: "focusData")?.isEmpty) != nil){
            self.stopTimer()
            self.motionManager.stopAccelerometerUpdates()
        }else{
            self.infoEndFocus.removeFromSuperview()
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            self.view.addGestureRecognizer(tapGesture)
            UIView.animate(withDuration: 0.4, animations: {
                self.infoEndSession.alpha = 0.0
                self.infoPodomoro.alpha = 0.0
                self.infoEndSessionIcon.alpha = 0.0
                self.infoEndSessionLabel.alpha = 0.0
                self.iconStop.alpha = 0.0
                self.stopContainer.alpha = 0.0
                self.infoInputTask.alpha = 1.0
                self.infoEndSession.alpha = 0.0
                self.infoEndSessionLabel.alpha = 0.0
                self.infoEndSessionIcon.alpha = 0.0
                self.infoEndSession.layer.zPosition = 12
                self.infoEndSessionIcon.layer.zPosition = 12
                self.infoEndSessionLabel.layer.zPosition = 12
                
            })
            didFinish()
        }
    }
    
    
    /// Motion Services
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
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motionData, error) in
                guard let motionData = motionData else { return }
                if self?.motionService.isShaking(motionData) == true {
                    self?.DidFinishAction()
                }
            }
        }
    }
    
    
    /// Animated button
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
    
    
    /// Minimum bare to get fish
    func checkMinimumBadge(_ timer: Int){
        
        if timerStart > 1200{
            endFocus.contentLabel.text = "Finish to see what you've caught!"
        }else{
            let theBareMinimum = 1200 - timerStart
            
            let finalBareTime = minuteToString(time: TimeInterval(theBareMinimum))
            
            endFocus.contentLabel.text = "Continue for another \(finalBareTime) minutes to get fish or nothing at all"
        }
        
    }
    
    
    /// convert second time to minute in string with format only minutes and minutes:seconds
    func minuteToString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        
        return String(format: "%02i", minute)
    }
    
    func timerToString(time: TimeInterval) -> String
    {
        let minute = Int(time) / 60
        let second = Int(time) % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
    
    /// finished focus session and save data
    @objc func continueResult(){
        
        guard let text = inputTaskTextField.text, !text.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in the text field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        gachaSytem.gachaPull()
        let setFish = gachaSytem.setFish
        let setRarerity = gachaSytem.setRarerity
        
        // Save content
        let dataPersistence = DataPersistence(timerStart: timerStart, text: text, setFish: setFish , rarerity: setRarerity)
        dataPersistence.saveContent()
        
        let vc = ResultViewController(time: minuteToString(time: TimeInterval(timerStart)), activity: text, fish: timerStart >= 1200 ? setFish : "nil", rare: timerStart >= 1200 ? setRarerity : "nil")
        gachaSytem.reset()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// hide and unhide timer
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
    
    
    /// Show/unshow info in pause screen
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
    
    
    /// action if finish btn press
    @objc func btnFinish(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        didFinish()
    }
    
    func didFinish(){
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
    
    
    /// hide keyboard if press anywhere in screen and delegate for set max length of textfield
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > 20 {
            let alert = UIAlertController(title: "Error", message: "Maximum input length is 20 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    /// stop and cancel button action
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
            self.motionManager.startAccelerometerUpdates()
            self.checkRaisePhone()
        })
    }
    
    
    /// handle swipe down action in app
    @objc func handleSwipeDown(_ gesture : UISwipeGestureRecognizer){
        animatePause()
        activeGestureView()
        
        if gesture.state == .ended {
            // Run the swipe down action
            SwipeDownAction()
        }
    }
    
    func SwipeDownAction(){
        
        UIView.animate(withDuration: 0.5, animations: {
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
            self.videoBgFocus.alpha = 1.0
            self.tempFocus.alpha = 1.0
            self.videoBgReel.alpha = 0.0
            self.videoBgPause.alpha = 0.0
            self.tempReel.alpha = 0.0
            self.tempPause.alpha = 0.0
        })
        if timer != nil {
            timer?.invalidate()
            startTimer()
        }
        playVideoFocus()
        reel?.pause()
        pause?.pause()
    }
    
    
    /// make it active and inactive gesture in parent view
    func inActiveGestureView(){
        if let recog = view.gestureRecognizers{
            for recognizer in recog {
                recognizer.isEnabled = false
            }
        }
    }
    
    func activeGestureView(){
        if let recog = view.gestureRecognizers{
            for recognizer in recog {
                recognizer.isEnabled = true
            }
        }
    }
    

    /// timer management
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerLabel() {
        // Update the timer label with the current time
        timerStart += 1
        podomoroTime += 1
        
        if podomoroTime == 1200{
            
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
    
    func stopTimer() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            self.checkMinimumBadge(timerStart)
            
            inActiveGestureView()
            
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
    
    
    /// handleSwipe Up in App
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            // start animated swipe pause/resume swipe btn
            animatePause()
            
            // run the Swipe Up action
            SwipeUpAction()
            
        }
    }
    
    func SwipeUpAction(){
        if let recog = view.gestureRecognizers{
            for recognizer in recog {
                recognizer.isEnabled = false
            }
        }
        
        if timerPauseContainer.totalPauseTimer <= 0{
            UIView.animate(withDuration: 0.5, animations: {
                self.breakExhausted.alpha = 1.0
            })
        }else{
            playReelingAnimation()
            fokus?.pause()
            UIView.animate(withDuration: 0.5, animations: {
                self.videoBgFocus.alpha = 0.0
                self.tempFocus.alpha = 0.0
                self.videoBgReel.alpha = 1.0
                self.tempReel.alpha = 1.0
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.hideIcon.alpha = 0.0
                self.hideTimer.alpha = 0.0
                self.timerLabel.alpha = 0.0
                self.timerShownContainer.alpha = 0.0
                self.hideTimerIcon.alpha = 0.0
                self.iconStop.alpha = 0.0
                self.stopContainer.alpha = 0.0
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+2.05){
                let gestureswipeDownOnly = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeDown(_:)))
                gestureswipeDownOnly.direction = .down
                self.view.addGestureRecognizer(gestureswipeDownOnly)
                UIView.animate(withDuration: 0.5, animations: {
                    self.videoBgPause.alpha = 1.0
                    self.tempPause.alpha = 1.0
                    self.playVideoPause()
                    self.timerPauseContainer.alpha = 1.0
                    self.mainBg.image = UIImage(named: "bg-pause")
                    self.swipeUpIcon.image = UIImage(named: "icon-down")
                    self.swipeUpLabel.text = "Resume"
                })
            }
            
            
            if timer != nil {
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
            }
        }
    }
    
    
    /// life cycle in app
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

