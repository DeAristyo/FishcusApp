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

    // setup focus var
    var activity: String? = UserDefaults.standard.string(forKey: "activity") ?? "empty"
    var focusDuration: Int = UserDefaults.standard.integer(forKey: "focusDuration")
    var breakDuration: Int = UserDefaults.standard.integer(forKey: "breakDuration")
    var cycleSytem: Int = UserDefaults.standard.integer(forKey: "cycle")
    var timeRecap: [Int] = []

    
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
    var timerStart: Int = 0
    
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
                    self.infoEndSession.layer.zPosition = 15
                    self.infoEndSessionIcon.layer.zPosition = 15
                    self.infoEndSessionLabel.layer.zPosition = 15
                })
                
                self.view.addSubview(infoEndFocus)
                
                infoEndFocus.layer.zPosition = 12
                
                NSLayoutConstraint.activate([
                    infoEndFocus.topAnchor.constraint(equalTo: view.topAnchor),
                    infoEndFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    infoEndFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    infoEndFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                
                startMotionUpdates()
            }
        }
    }
    
    //CountDown label
    var initialCountValue = 3
    
    
    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.rounded(ofSize: 20, weight: .semibold)
        timerLabel.textColor = UIColor(named: "regular-text")
        timerLabel.layer.zPosition = 12
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel()
        label.text = "\(initialCountValue)"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 60, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 13
        
        return label
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
        stop.layer.zPosition = 99
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
        view.layer.backgroundColor = UIColor.MyColors.regularText.cgColor
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
        text.text = "In Break Time, feel free to relax and switch apps. If you'd like to end the session, simply pull out your phone to finish~"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.widthAnchor.constraint(equalToConstant: 274),
            text.heightAnchor.constraint(equalToConstant: 67)
        ])
        
        
        let image = UIImageView()
        image.image = UIImage(named: "icon-pull-out-black")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: text.bottomAnchor, constant: -20),
            image.trailingAnchor.constraint(equalTo: text.trailingAnchor),
        ])
        
        applyShakeAnimation2()
        
        func applyShakeAnimation2() {
            UIView.animate(withDuration: 0.5, animations: {
               image.transform = CGAffineTransform(translationX: 5, y: -8)
            }, completion: { done in
                
                if done{
                    LoopAnimate2()
                }
                
            })
        }
        
        func LoopAnimate2(){
            UIView.animate(withDuration: 1.5, animations: {
                image.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: { done in
                
                if done{
                    applyShakeAnimation2()
                }
                
            })
        }
        
        
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
    
    private var infoEndSessionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull your phone when you're done with tasks~"
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
        view.image = UIImage(named: "icon-pull-out")
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
    
    private var alertOnFocus: OnFocusAlerts = {
        let view = OnFocusAlerts(icon: .icon1, labelInfo: "You are currently in Focus Mode.")
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var alertOnPodomoro: OnFocusAlerts = {
        let view = OnFocusAlerts(icon: .icon2, labelInfo: "Unlock a well-deserved break after your session.")
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
    
    lazy private var labelPrepared: UILabel = {
        let labelPrepared = UILabel()
        labelPrepared.text = "Take a deep breath.."
        labelPrepared.font = UIFont.rounded(ofSize: 30, weight: .bold)
        labelPrepared.textColor = UIColor(named: "primaryColor")
        labelPrepared.layer.zPosition = 12
        labelPrepared.translatesAutoresizingMaskIntoConstraints = false
        
        return labelPrepared
    }()
    
    private var breakAlert: BreakAlert = {
        let view = BreakAlert(breakType: .breakType)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        
        return view
    }()
   
    private var finishAlert: BreakAlert = {
        let view = BreakAlert(breakType: .finishType)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        
        return view
    }()
    
    private var infoPullOut: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private var infoPullOutLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull your phone if you want to finish your break~"
        label.textAlignment = .center
        label.font = UIFont.rounded(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "regular-text")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var infoPullOutIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "icon-pull-out")
        view.layer.zPosition = 11
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground
        
        // View Configuration
        SetupDelegate()
        SetupAlpha()
        SetupView()
        SetupOnBoarding()
        SetupConstraint()
        SetupCountDownRing()
        
        // Gesture config
        SetupGesture()
        
        // Check min condition to get fish
        checkMinimumBadge(timerStart)
    
        // Shake Animation
        applyShakeAnimation()
        
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
        applyShakeAnimation()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    /// func start with Setup is related to view coniguration to viewdidload
    func SetupAlpha(){
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
        infoInputTask.alpha = 0.0
        videoBgReel.alpha = 0.0
        tempReel.alpha = 0.0
        videoBgPause.alpha = 0.0
        tempPause.alpha = 0.0
        alertOnFocus.alpha = 0.0
    }
    
    
    /// Delegate handler
    func SetupDelegate(){
        inputTaskTextField.delegate =  self
        timerPauseContainer.delegate = self
        podomoroAlerts.delegate = self
        breakAlert.breakAlertDelegate = self
        finishAlert.breakAlertDelegate = self
    }
    
    func breakBtn() {
        UIView.animate(withDuration: 0.5, animations: {
            self.breakAlert.alpha = 0.0
        })
        
        
    }
    
    func ResetFocusMode(){
        RemoveInfoPullOut()
        motionManager.stopAccelerometerUpdates()
        UIView.animate(withDuration: 0.5, animations: {
            self.breakAlert.alpha = 0.0
            self.finishAlert.alpha = 0.0
            self.initialCountValue = 3
            self.view.addSubview(self.countDownLabel)
            self.countDownLabel.text = "\(self.initialCountValue)"
            self.labelPrepared.alpha = 1.0
            self.countDownLabel.layer.zPosition = 13
            self.labelPrepared.layer.zPosition = 13
        })
        
       
        NSLayoutConstraint.activate([
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        self.timerStart = 290
        self.timerPauseContainer.totalPauseTimer = breakDuration
        self.countDownTimer.ringWidth = 10.0
        self.countDownTimer.countdownDuration = 03.0
        self.countDownTimer.startTime = Date()
        self.countDownTimer.ringLayer.strokeStart = 0
        self.countDownTimer.ringLayer.strokeEnd = 1.0
        self.timerLabel.text = "00:00"
    }
    
    func continueBtn() {
        //Reset focus mode
        ResetFocusMode()
        
        // Start timer countdown
        self.StartCountDownRing()
        self.countDownTimer.startCountdown()
      
        SwipeDownAction()
    }
    
    func finishBtn() {
        FinishResult()
    }
    
    
    /// rendering a view
    func SetupView(){
        view.addSubview(videoBgFocus)
        view.addSubview(tempFocus)
        view.addSubview(videoBgReel)
        view.addSubview(tempReel)
        view.addSubview(videoBgPause)
        view.addSubview(tempPause)
        view.addSubview(podomoroAlerts)
        view.addSubview(hideTimer)
        hideTimer.addSubview(hideIcon)
        view.addSubview(infoLabel)
        view.addSubview(endFocus)
        view.addSubview(btnContinue)
        view.addSubview(timerPauseContainer)
        timerPauseContainer.totalPauseTimer = breakDuration
        view.addSubview(stopContainer)
        view.addSubview(timerShownContainer)
        timerShownContainer.addSubview(hideTimerIcon)
        timerLabel.text = "00:00"
        timerShownContainer.addSubview(timerLabel)
        view.addSubview(infoEndSession)
        infoEndSession.addSubview(infoEndSessionIcon)
        infoEndSession.addSubview(infoEndSessionLabel)
        view.addSubview(bgInputTask)
        view.addSubview(containerInputTask)
        containerInputTask.addSubview(inputTaskTitle)
        containerInputTask.addSubview(inputTaskTextField)
        containerInputTask.addSubview(inputTaskBtn)
        view.addSubview(alertOnFocus)
        view.addSubview(alertOnPodomoro)
        view.addSubview(infoInputTask)
        infoInputTask.layer.zPosition = 12
        view.addSubview(countDownLabel)
        view.addSubview(breakAlert)
        view.addSubview(finishAlert)
        view.addSubview(iconStop)
        view.addSubview(iconCancel)
    }
    
    func SetupConstraint(){

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
            iconStop.widthAnchor.constraint(equalToConstant: 22),
            iconStop.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            iconCancel.centerXAnchor.constraint(equalTo: stopContainer.centerXAnchor),
            iconCancel.centerYAnchor.constraint(equalTo: stopContainer.centerYAnchor),
            iconCancel.widthAnchor.constraint(equalToConstant: 18),
            iconCancel.heightAnchor.constraint(equalToConstant: 18)
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
            infoEndSessionIcon.widthAnchor.constraint(equalToConstant: 37),
            infoEndSessionIcon.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            infoEndSessionLabel.centerYAnchor.constraint(equalTo: infoEndSession.centerYAnchor),
            infoEndSessionLabel.leadingAnchor.constraint(equalTo: infoEndSessionIcon.trailingAnchor, constant: 17),
            infoEndSessionLabel.widthAnchor.constraint(equalToConstant: 231),
            infoEndSessionLabel.heightAnchor.constraint(equalToConstant: 50)
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
        
        NSLayoutConstraint.activate([
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            breakAlert.topAnchor.constraint(equalTo: view.topAnchor),
            breakAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breakAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breakAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            finishAlert.topAnchor.constraint(equalTo: view.topAnchor),
            finishAlert.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            finishAlert.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            finishAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func SetupOnBoarding(){
        if ((myUserDefault.data(forKey: "focusData")?.isEmpty) == nil){
            stopMotionUpdate()
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
            
            
            StartCountDownRing()
            countDownTimer.startCountdown()
            
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
    
    
    /// setup countdown ring
    @objc func countDownUpdate(){
        if initialCountValue > 0 {
            initialCountValue -= 1
            UIView.transition(with: countDownLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.countDownLabel.text = "\(self.initialCountValue)"
            })
        }
    }
    
    func SetupCountDownRing(){
        
        if((self.myUserDefault.data(forKey: "focusData")?.isEmpty) != nil){
            view.addSubview(labelPrepared)
            
            NSLayoutConstraint.activate([
                labelPrepared.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
                labelPrepared.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            view.addSubview(countDownTimer)
            countDownTimer.translatesAutoresizingMaskIntoConstraints = false
            countDownTimer.layer.zPosition = 12
            countDownTimer.transform = CGAffineTransform(rotationAngle: -90 * .pi / 180.0)
            
            
            NSLayoutConstraint.activate([
                countDownTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                countDownTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
           
        }
       
    }
    
    func StartCountDownLabel(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownUpdate), userInfo: nil, repeats: true)
    }
    
    func StartCountDownRing(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.zPosition = 12
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.9
        
        view.addSubview(blurEffectView)
        
        SetupCountDownRing()
        
        StartCountDownLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3.5){
            // Create and start the timer
            self.countDownLabel.removeFromSuperview()
            
            if self.timer != nil{
                self.timer?.invalidate()
                self.startTimer()
            }
            
            if((self.myUserDefault.data(forKey: "focusData")?.isEmpty) != nil){
                UIView.animate(withDuration: 0.5, animations: {
                    self.alertOnFocus.alpha = 1.0
                })
            }
            blurEffectView.removeFromSuperview()
            self.labelPrepared.removeFromSuperview()
            self.countDownTimer.removeFromSuperview()
        }
    }
    
    
    /// setup gesture
    func SetupGesture(){
        
        // Create gesture recognizer
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
        
    }
    
    
    
    ///Setup Animation Shake
    func applyShakeAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.infoEndSessionIcon.transform = CGAffineTransform(translationX: 5, y: -8)
            self.infoPullOutIcon.transform = CGAffineTransform(translationX: 5, y: -8)
        }, completion: { done in
            
            if done{
                self.LoopAnimate()
            }
            
        })
    }
    
    func LoopAnimate(){
        UIView.animate(withDuration: 1.5, animations: {
            self.infoEndSessionIcon.transform = CGAffineTransform(translationX: 0, y: 0)
            self.infoPullOutIcon.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { done in
            
            if done{
                self.applyShakeAnimation()
            }
            
        })
    }
    
    
    /// Setup Video Layer as Background
    func SetupBackgroundLayerVideo(){
        var urlVideo = ""
        var reelingVideo = ""
        var pauseVideo = ""
        
        switch cycleSytem{
        case 1:
            urlVideo = "FocusModeAnimation"
            reelingVideo = "ReelingAnimation"
            pauseVideo = "PauseModeAnimation"
            break
        case 2:
            urlVideo = "focus-evening"
            reelingVideo = "reeling-evening"
            pauseVideo = "pause-evening"
            break
        case 3:
            urlVideo = "focus-night"
            reelingVideo = "reeling-night"
            pauseVideo = "pause-night"
            break
        default:
            urlVideo = "FocusModeAnimation"
            reelingVideo = "ReelingAnimation"
            pauseVideo = "PauseModeAnimation"
            break
        }
        
        
        guard let pathFocus = Bundle.main.path(forResource: "\(urlVideo)", ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        guard let pathReel = Bundle.main.path(forResource: "\(reelingVideo)", ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        guard let pathPause = Bundle.main.path(forResource: "\(pauseVideo)", ofType: "mov") else {
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
        startMotionUpdates()
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
                
                // Start pause action
                SwipeUpAction()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2.05){
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(self.guideTapGesture))
                    nextView.addGestureRecognizer(gesture)
                }
                break
                
            case 4:
                self.timerLabel.layer.zPosition = 12
                self.timerShownContainer.layer.zPosition = 12
                self.hideTimerIcon.layer.zPosition = 12
                let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
                nextView.addGestureRecognizer(gesture)
                break
            case 5:
                activeGestureView()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.infoEndSession.alpha = 1.0
                    self.infoEndSession.layer.zPosition = 15
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
        }
    }
    
    
    /// Motion Services
    func ShowInfoPullOut(){
        
        infoPullOut.alpha = 0.0
        infoPullOutIcon.alpha = 0.0
        infoPullOutLabel.alpha = 0.0
        
        view.addSubview(infoPullOut)
        infoPullOut.addSubview(infoPullOutLabel)
        infoPullOut.addSubview(infoPullOutIcon)
        
        NSLayoutConstraint.activate([
            infoPullOut.topAnchor.constraint(equalTo: view.topAnchor, constant: 240),
            infoPullOut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoPullOut.widthAnchor.constraint(equalToConstant: 335),
            infoPullOut.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            infoPullOutIcon.centerYAnchor.constraint(equalTo: infoPullOut.centerYAnchor),
            infoPullOutIcon.leadingAnchor.constraint(equalTo: infoPullOut.leadingAnchor, constant: 22),
            infoPullOutIcon.widthAnchor.constraint(equalToConstant: 37),
            infoPullOutIcon.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            infoPullOutLabel.centerYAnchor.constraint(equalTo: infoPullOut.centerYAnchor),
            infoPullOutLabel.leadingAnchor.constraint(equalTo: infoPullOutIcon.trailingAnchor, constant: 17),
            infoPullOutLabel.widthAnchor.constraint(equalToConstant: 231),
            infoPullOutLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func RemoveInfoPullOut(){
        infoPullOut.removeFromSuperview()
        infoPullOutIcon.removeFromSuperview()
        infoPullOutLabel.removeFromSuperview()
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
                    
                        UIView.animate(withDuration: 0.5, animations: {
                            self.infoPullOut.alpha = 1.0
                            self.infoPullOutIcon.alpha = 1.0
                            self.infoPullOutLabel.alpha = 1.0
                        })
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+5.0){
                            UIView.animate(withDuration: 0.5, animations: {
                                self.infoPullOut.alpha = 0.0
                                self.infoPullOutIcon.alpha = 0.0
                                self.infoPullOutLabel.alpha = 0.0
                            })
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
    
    func stopMotionUpdate(){
        motionManager.stopDeviceMotionUpdates()
    }
    
    
    /// Minimum bare to get fish
    func checkMinimumBadge(_ timer: Int){
        
        if timerStart < focusDuration{
            let theBareMinimum = focusDuration - timerStart
            
            let finalBareTime = minuteToString(time: TimeInterval(theBareMinimum))
            
            endFocus.contentLabel.text = "Continue for another \(finalBareTime == "00" ? "few seconds" : finalBareTime+" minutes" ) to get fish"
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
        FinishResult()
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
       FinishResult()
    }
    
    func FinishResult(){
        guard let text = activity, activity != "" else{return}
        
        var setFish = ""
        var setRarerity = ""
        
        if timerStart >= focusDuration{
            switch timerStart {
            case 0...1499:
                gachaSytem.gachaPullGroup1()
                break
            case 1500...2940:
                gachaSytem.gachaPullGroup2()
                break
            case 3000...5340:
                gachaSytem.gachaPullGroup3()
                break
            default:
                gachaSytem.gachaPullGroup4()
                break
            }
            
            setFish = gachaSytem.setFish
            setRarerity = gachaSytem.setRarerity
        }else{
            setFish = "nil"
            setRarerity = "nil"
        }
    
        
        // Save content
        let dataPersistence = DataPersistence(timerStart: timerStart, text: text, setFish: setFish , rarerity: setRarerity)
        dataPersistence.saveContent()
        
        let vc = ResultViewController(time: minuteToString(time: TimeInterval(timerStart)), activity: text, fish: setFish, rare: setRarerity, rootView: false )
        gachaSytem.reset()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// hide keyboard if press anywhere in screen and delegate for set max length of textfield
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    /// stop and cancel button action
    @objc func stopBtnFocus(){
        UIView.animate(withDuration: 0.5, animations: {
            self.infoEndSession.alpha = 1.0
            self.infoEndSessionIcon.alpha = 1.0
            self.infoEndSessionLabel.alpha = 1.0
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
        
        if timerStart >= focusDuration{
            if timer != nil{
                timer?.invalidate()
                timeRecap.append(timerStart)
                print(timeRecap)
                checkRaisePhone()
                ShowInfoPullOut()
                SwipeUpAction()
            }
        }
        
        let currentTime = timerToString(time: TimeInterval(timerStart))
        timerLabel.text = currentTime
        
    }
    
    @objc func updatePauseTimerLabel(){
        
        if timerPauseContainer.totalPauseTimer <= 0{
            if timer != nil{
                timer?.invalidate()
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.finishAlert.layer.zPosition = 13
                self.finishAlert.alpha = 1.0
            })
        }else{
            timerPauseContainer.updatePauseTimer()
        }
        
    }
    
    func stopTimer() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        if timer != nil {
           
            if timerStart >= focusDuration && timerPauseContainer.totalPauseTimer != 0{
                UIView.animate(withDuration: 0.5, animations: {
                    self.breakAlert.alpha = 1.0
                })
            }else{
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
    }
    
    
    /// handleSwipe Up in App
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            
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
            
            UIView.animate(withDuration: 0.5, animations: {
                self.videoBgPause.alpha = 1.0
                self.tempPause.alpha = 1.0
                self.playVideoPause()
                self.timerPauseContainer.alpha = 1.0
                self.mainBg.image = UIImage(named: "bg-pause")
                self.breakAlert.alpha = 1.0
                self.breakAlert.layer.zPosition = 13
            })
        }
        
        
        if timer != nil {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
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

