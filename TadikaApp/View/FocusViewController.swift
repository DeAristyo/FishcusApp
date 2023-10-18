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
    
    private var text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        // Create and configure a UILabel to display the timer
//        timerLabel.text = "00:00:00"
//        view.addSubview(timerLabel)
        
      
        view.addSubview(iconStop)
        
        NSLayoutConstraint.activate([
            iconStop.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iconStop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            iconStop.widthAnchor.constraint(equalToConstant: 40),
            iconStop.heightAnchor.constraint(equalToConstant: 40)
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

