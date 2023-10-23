//
//  FocusViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 17/10/23.
//

import UIKit
import CoreMotion
import CoreHaptics

class FocusViewController: UIViewController {
   
    
   
    var timer: Timer?
    var engine: CHHapticEngine?
    var showInfo = false
    var infoStep = 0
    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    
    var timerStart: Int = 0
    
    let motionManager = CMMotionManager()
    let motionThreshold: Double = 5.0 // Adjust the threshold as needed
    
    
    private var mainBg: UIImageView = {
       let fishing =  UIImageView()
        fishing.image = UIImage(named: "bg-3")
        fishing.contentMode = .scaleAspectFill
        fishing.layer.zPosition = 1
        fishing.translatesAutoresizingMaskIntoConstraints = false
        
        return fishing
    }()
    
    private var iconStop: UIImageView = {
        let stop = UIImageView()
        stop.image = UIImage(systemName: "stop.fill")
        stop.tintColor = .white
        stop.contentMode = .center
        stop.backgroundColor = UIColor(named: "primaryColor")
        stop.clipsToBounds = true
        stop.layer.cornerRadius = 10
        stop.layer.zPosition = 10
        stop.translatesAutoresizingMaskIntoConstraints = false
    
        return stop
    }()
    
    private var iconCancel: UIImageView = {
        let stop = UIImageView()
        stop.image = UIImage(systemName: "xmark")
        stop.tintColor = .white
        stop.contentMode = .center
        stop.backgroundColor = UIColor(named: "primaryColor")
        stop.clipsToBounds = true
        stop.layer.cornerRadius = 10
        stop.layer.zPosition = 12
        stop.translatesAutoresizingMaskIntoConstraints = false
    
        return stop
    }()
    
    
     var timerPauseContainer: TimerPause = {
         let view = TimerPause()
         view.layer.zPosition = 11
         view.translatesAutoresizingMaskIntoConstraints = false
         
         return view
     }()
    
    private var endFocus: EndFocus = {
       let view = EndFocus()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var infoIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "info.circle.fill")
        image.tintColor = .white
        image.contentMode = .center
        image.clipsToBounds = true
        image.layer.zPosition = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    private var userGuide1: UserGuide = {
        let view = UserGuide()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var userGuide2: UserGuide2 = {
        let view = UserGuide2()
        view.layer.zPosition = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var userGuide3: UserGuide3 = {
        let view = UserGuide3()
        view.layer.zPosition = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var userGuide4: UserGuide4 = {
        let view = UserGuide4()
        view.layer.zPosition = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        timerPauseContainer.alpha = 0.0
        endFocus.alpha = 0.0
        iconCancel.alpha = 0.0
        infoIcon.alpha = 0.0
        infoLabel.alpha = 0.0
        endHome.alpha = 0.0
        btnContinue.alpha = 0.0
        btnBackHome.alpha = 0.0
        userGuide1.alpha = infoStep == 0 ? 1.0 : 0.0
        userGuide2.alpha = 0.0
        userGuide3.alpha = 0.0
        userGuide4.alpha = 0.0
        
        // Create and configure a UILabel to display the timer
//        timerLabel.text = "00:00:00"
//        view.addSubview(timerLabel)
        
        view.addSubview(userGuide4)
        
        NSLayoutConstraint.activate([
            userGuide4.topAnchor.constraint(equalTo: view.topAnchor),
            userGuide4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userGuide4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userGuide4.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(userGuide3)
        
        NSLayoutConstraint.activate([
            userGuide3.topAnchor.constraint(equalTo: view.topAnchor),
            userGuide3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userGuide3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userGuide3.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(userGuide1)
        
        NSLayoutConstraint.activate([
            userGuide1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -352)
        ])
        
        view.addSubview(userGuide2)
        
        NSLayoutConstraint.activate([
            userGuide2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -352)
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
            btnContinue.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90)
        ])
        
        view.addSubview(btnBackHome)
        NSLayoutConstraint.activate([
            btnBackHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnBackHome.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90)
        ])
        
        view.addSubview(timerPauseContainer)
        
        NSLayoutConstraint.activate([
            timerPauseContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
       
        view.addSubview(iconStop)
        
        NSLayoutConstraint.activate([
            iconStop.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconStop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconStop.widthAnchor.constraint(equalToConstant: 40),
            iconStop.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(infoIcon)
        
        NSLayoutConstraint.activate([
            infoIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            infoIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoIcon.widthAnchor.constraint(equalToConstant: 44),
            infoIcon.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        view.addSubview(iconCancel)
        
        NSLayoutConstraint.activate([
            iconCancel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconCancel.widthAnchor.constraint(equalToConstant: 40),
            iconCancel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(mainBg)
        
        NSLayoutConstraint.activate([
            mainBg.topAnchor.constraint(equalTo: view.topAnchor),
            mainBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
       

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
        
        let cancelEndGesture =  UITapGestureRecognizer(target: self, action: #selector(cancelEndFocus))
        iconCancel.isUserInteractionEnabled = true
        iconCancel.addGestureRecognizer(cancelEndGesture)
        
        let stopEndGesture =  UITapGestureRecognizer(target: self, action: #selector(stopBtnFocus))
        iconStop.isUserInteractionEnabled = true
        iconStop.addGestureRecognizer(stopEndGesture)
        
//        timerPauseContainer.showInfoAction = { [weak self] in
//            self?.showInfo.toggle()
//            print("showInfo is now \(self?.showInfo ?? false)")
//        }
        
        let infoGesture =  UITapGestureRecognizer(target: self, action: #selector(infoShow))
        infoIcon.isUserInteractionEnabled = true
        infoIcon.addGestureRecognizer(infoGesture)
        
        let btnFinishGesture = UITapGestureRecognizer(target: self, action: #selector(btnFinish))
        btnContinue.isUserInteractionEnabled = true
        btnContinue.addGestureRecognizer(btnFinishGesture)
        
        let btnBackGesture = UITapGestureRecognizer(target: self, action: #selector(btnHome))
        btnBackHome.isUserInteractionEnabled = true
        btnBackHome.addGestureRecognizer(btnBackGesture)
        
        let infoGestureRecog = UITapGestureRecognizer(target: self, action: #selector(infoChange))
        view.addGestureRecognizer(infoGestureRecog)
        
    }
    
    @objc func infoChange(){
        infoStep += 1
        
        switch infoStep{
        case 1:
            UIView.animate(withDuration: 0.4, animations: {
                self.userGuide1.alpha = 0.0
                self.userGuide2.alpha = 1.0
            })
            break
            
        case 2:
            UIView.animate(withDuration: 0.4, animations: {
                self.userGuide2.alpha = 0.0
                self.userGuide3.alpha = 1.0
                self.timerPauseContainer.alpha = 1.0
                self.infoIcon.alpha = 1.0
            })
            break
        case 3:
            UIView.animate(withDuration: 0.4, animations: {
                self.userGuide3.alpha = 0.0
                self.userGuide4.alpha = 1.0
                self.timerPauseContainer.alpha = 1.0
                self.infoIcon.alpha = 1.0
            })
            break
        default:
            print("selesai")
        }
    }
    
    @objc func btnFinish(){
        UIView.animate(withDuration: 0.5, animations: {
            self.endHome.alpha = 1.0
            self.btnBackHome.alpha = 1.0
        })
    }
    
    @objc func btnHome(){
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func infoShow(){
        print("masukk cuyyy")
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
    
    
    @objc func stopBtnFocus(){
        complexSuccess()
       stopTimer()
    }
    
    @objc func cancelEndFocus(){
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
                self.infoIcon.alpha = 0.0
                self.infoLabel.alpha = 0.0
                self.userGuide4.alpha = 0.0
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
        timerPauseContainer.updatePauseTimer()
    }
    
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.timerPauseContainer.alpha = 1.0
                self.iconStop.alpha = 0.0
                self.infoIcon.alpha = 1.0
            })
            
            complexSuccess()
            
            if timer != nil {
                timer?.invalidate()
//                showStopTimerAlert()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePauseTimerLabel), userInfo: nil, repeats: true)
            }
           
        }
    }
    
    @objc func updateTimerLabel() {
        // Update the timer label with the current time
        timerStart += 1
        let currentTime = timerToString(time: TimeInterval(timerStart))
        print(currentTime)
        timerLabel.text = currentTime
        
    }
    
    func timerToString(time: TimeInterval) -> String
    {
        let hours = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minute, second)
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
            UIView.animate(withDuration: 0.4, animations: {
                self.endFocus.alpha = 1.0
                self.iconStop.alpha = 0.0
                self.iconCancel.alpha = 1.0
                self.timerPauseContainer.alpha = 0.0
                self.infoIcon.alpha = 0.0
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
            print("Ngk ada haptic hp mu blok : \(error.localizedDescription)")
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the timer when the view disappears
        timer?.invalidate()
    }
    
    
}

