//
//  FocusViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 17/10/23.
//

import UIKit
import CoreMotion

class FocusViewController: UIViewController {
    
    var timer: Timer?
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
    
    private var bgFocus: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 518)
        let layer0 = CAGradientLayer()
        layer0.colors = [
        UIColor(red: 0.616, green: 0.776, blue: 0.882, alpha: 1).cgColor,
        UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var fishing: UIImageView = {
       let fishing =  UIImageView()
        fishing.image = UIImage(named: "fishing")
        fishing.contentMode = .scaleAspectFit
        fishing.layer.zPosition = 1
        fishing.translatesAutoresizingMaskIntoConstraints = false
        
        return fishing
    }()
    
    private var iconMusic: UIImageView = {
        let music = UIImageView()
        music.image = UIImage(systemName: "music.note")
        music.tintColor = .white
        music.contentMode = .center
        music.backgroundColor = .gray
        music.clipsToBounds = true
        music.layer.cornerRadius = 10
        music.translatesAutoresizingMaskIntoConstraints = false
        
        return music
    }()
    
    private var iconPlay: UIImageView = {
        let play = UIImageView()
        play.image = UIImage(systemName: "play.fill")
        play.tintColor = .white
        play.contentMode = .center
        play.backgroundColor = .gray
        play.clipsToBounds = true
        play.layer.cornerRadius = 10
        play.translatesAutoresizingMaskIntoConstraints = false
        
        return play
    }()
    
    private var iconStop: UIImageView = {
        let stop = UIImageView()
        stop.image = UIImage(systemName: "stop.fill")
        stop.tintColor = .white
        stop.contentMode = .center
        stop.backgroundColor = .gray
        stop.clipsToBounds = true
        stop.layer.cornerRadius = 10
        stop.translatesAutoresizingMaskIntoConstraints = false
    
        return stop
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        // Create and configure a UILabel to display the timer
//        timerLabel.text = "00:00:00"
//        view.addSubview(timerLabel)
        
        
        
        view.addSubview(iconMusic)
        
        NSLayoutConstraint.activate([
            iconMusic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconMusic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iconMusic.widthAnchor.constraint(equalToConstant: 40),
            iconMusic.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(iconPlay)
        
        NSLayoutConstraint.activate([
            iconPlay.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconPlay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            iconPlay.widthAnchor.constraint(equalToConstant: 40),
            iconPlay.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(iconStop)
        
        NSLayoutConstraint.activate([
            iconStop.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconStop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconStop.widthAnchor.constraint(equalToConstant: 40),
            iconStop.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(fishing)
        
        NSLayoutConstraint.activate([
            fishing.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -12),
            fishing.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fishing.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(bgFocus)
        
        NSLayoutConstraint.activate([
            bgFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgFocus.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
        
                
        // Create and start the timer
        startTimer()
        
        startMotionUpdates()
        
        // Create a swipe gesture recognizer
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        view.addGestureRecognizer(swipeGesture)
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            
            if timer != nil {
                timer?.invalidate()
                showStopTimerAlert()
            }
           
        }
    }
    
    @objc func updateTimerLabel() {
        // Update the timer label with the current time
        timerStart += 1
        let currentTime = timerToString(time: TimeInterval(timerStart))
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
            showStopTimerAlert()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the timer when the view disappears
        timer?.invalidate()
    }
    

    
    
}

