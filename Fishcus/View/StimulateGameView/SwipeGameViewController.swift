//
//  SwipeGameViewController.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 15/11/23.
//

import Foundation
import UIKit

class SwipeGameViewController: UIViewController{
    
    init(isStimulateGame: Bool){
        self.isStimulateGame = isStimulateGame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //View variable declaration
    private let isiPhoneSE = UIScreen.main.bounds.height <= 667
    private let progressBar = ProgressBarView()
    private var gameLevel = 1
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    private var wrongSwipe = 0
    private let countDownTimer = CountdownRingView()
    private var initialCountValue = 3
    private var initialCountTimer: Timer!
    private var isGameStarting: Bool = false
    private var fishCounts: [String: Int] = ["RedFish": 0, "BlueFish": 0, "GreenFish": 0]
    private var fishTypes = ["RedFish", "BlueFish", "GreenFish"]
    private var arrowDirection: String = ""
    private var previousArrow: String = ""
    private var isStimulateGame: Bool = false
    
    //Count Down top Label view
    lazy var countDownTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Ready!"
        label.textColor = UIColor(named: "primaryColor")
        label.layer.shadowColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.1
        label.layer.zPosition = 2
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.zPosition = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    //Count down label
    lazy var countDownLabel: UILabel = {
        let label = UILabel()
        label.text = "\(initialCountValue)"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 60, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    //Divider
    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "regular-text")
        view.alpha = 0.0
        
        return view
    }()
    
    //View background
    lazy var mainBg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "FishGameBG")
        bg.contentMode = .scaleAspectFill
        bg.layer.zPosition = -999
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        return bg
    }()
    
    //Overlay Background
    lazy var overlayBg: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white.withAlphaComponent(0.5)
        bg.layer.zPosition = -100
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.alpha = 0.0
        
        return bg
    }()
    
    //Info Overlay Background
    lazy var infoOverlayBg: UIView = {
        let bg = UIView()
        bg.backgroundColor = .black.withAlphaComponent(0.5)
        bg.layer.zPosition = -995
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        return bg
    }()
    
    //Warning Rectangle
    lazy var warningView: UIView = {
        let warning = UIView()
        warning.backgroundColor = UIColor(named: "primaryColor")
        warning.layer.cornerRadius = 25
        warning.translatesAutoresizingMaskIntoConstraints = false
        warning.alpha = 0.0
        
        return warning
    }()
    
    //Warning Label view
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Great"
        label.textColor = UIColor(named: "highlight-text")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    //Warning Message view
    lazy var warningMessage: UILabel = {
        let label = UILabel()
        label.text = "You seem to be focused! Ready for your study session?"
        label.textColor = UIColor(named: "regular-text")
        label.textAlignment = .center
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    //Warning Label view
    lazy var buttonText: UILabel = {
        let label = UILabel()
        label.text = isStimulateGame ? "Let’s go!" : "Back"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    //Warning Button
    lazy var warningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-empty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextScreen(_:)), for: .touchUpInside)
        button.layer.zPosition = 1
        button.alpha = 0.0
        
        return button
    }()
    
    //Info Rectangle
    lazy var infoView: UIView = {
        let warning = UIView()
        warning.backgroundColor = UIColor(named: "primaryColor")
        warning.layer.cornerRadius = 35
        warning.translatesAutoresizingMaskIntoConstraints = false
        
        return warning
    }()
    
    //Info image
    lazy var infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "swipeGameTutorial")
        image.clipsToBounds = true
        image.layer.zPosition = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    //Info button Label view
    lazy var infoButtonText: UILabel = {
        let label = UILabel()
        label.text = "Play!"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Info Button
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-empty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(startGameElements(_:)), for: .touchUpInside)
        
        return button
    }()
    
    //Info Skip button Label view
    lazy var skipButtonText: UILabel = {
        let label = UILabel()
        label.text = "Skip"
        label.textColor = UIColor(named: "regular-text")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Info Button
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(nextScreen(_:)), for: .touchUpInside)
        button.alpha = isStimulateGame ? 1.0 : 0.0
        
        return button
    }()
    
    //Info Label view
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe or\nUnswipe!"
        label.textColor = UIColor(named: "regular-text")
        label.layer.shadowColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.1
        label.layer.zPosition = 2
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Info Message view
    lazy var infoMessage: UILabel = {
        let label = UILabel()
        label.text = "Swipe by following or\nunfollowing the direction!"
        label.textColor = UIColor(named: "regular-text")
        label.textAlignment = .center
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Game spaces / the rectangular space to generate the bubble
    lazy var gameBg: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.clear
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.alpha = 0.0
        
        return rectangle
    }()
    
    //Label view
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Swipe in order or in reverse!"
        label.textColor = UIColor(named: "primaryColor")
        label.layer.shadowColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.1
        label.layer.zPosition = 2
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "UpGreen")
        arrow.layer.zPosition = 20
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        return arrow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the subviews
        subviews()
        
        // Initialize the feedback generator
        feedbackGenerator.prepare()
        
        //Generate random arrow
        generateRandomArrow()
        
        //Call the constraint function
        setupLayout()
        
        //Setup the swipe gesture
        setupGestures()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = .systemBackground
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.alpha = 0.0
        countDownTimer.translatesAutoresizingMaskIntoConstraints = false
        countDownTimer.layer.zPosition = 10
        countDownTimer.transform = CGAffineTransform(rotationAngle: -90 * .pi / 180.0)
        countDownTimer.alpha = 0.0
        
    }
    
    func subviews(){
        //View subviews
        view.addSubview(mainBg)
        view.addSubview(progressBar)
        view.addSubview(countDownTimer)
        view.addSubview(countDownLabel)
        view.addSubview(countDownTopLabel)
        view.addSubview(label)
        view.addSubview(gameBg)
        view.addSubview(overlayBg)
        view.addSubview(warningView)
        view.addSubview(infoOverlayBg)
        
        //GameBg Subview
        gameBg.addSubview(arrowImage)
        
        //Warning view subviews
        warningView.addSubview(warningLabel)
        warningView.addSubview(divider)
        warningView.addSubview(warningMessage)
        warningView.addSubview(warningButton)
        
        //Warning button subviews
        warningButton.addSubview(buttonText)
        
        //Info overlay subviews
        infoOverlayBg.addSubview(infoButton)
        infoOverlayBg.addSubview(infoView)
        infoOverlayBg.addSubview(infoLabel)
        infoOverlayBg.addSubview(skipButton)
        
        //Info button subviews
        infoButton.addSubview(infoButtonText)
        
        //Info View subviews
        infoView.addSubview(infoImage)
        infoView.addSubview(infoMessage)
        
        //Skip button subview
        skipButton.addSubview(skipButtonText)
        
    }
    
    @objc func nextScreen(_ sender: UIButton){
        if isStimulateGame{
            let vc = FocusViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @objc func updateCountdown() {
        if initialCountValue > 0 {
            initialCountValue -= 1
            UIView.transition(with: countDownLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.countDownLabel.text = "\(self.initialCountValue)"
            })
        } else {
            initialCountTimer.invalidate()
            fadeInElements()
        }
    }
    
    func fadeInElements() {
        isGameStarting = true
        UIView.animate(withDuration: 0.5, animations: {
            // Set the alpha of elements to 0.0 for a fade-out effect
            self.countDownTimer.alpha = 0.0
            self.countDownLabel.alpha = 0.0
            self.countDownTopLabel.alpha = 0.0
        }){ _ in
            self.countDownTopLabel.removeFromSuperview()
            self.countDownTimer.removeFromSuperview()
            self.countDownLabel.removeFromSuperview()
            // After fade-out animation completes, set the alpha of overlayBg to 1.0 with fadeIn animation
            UIView.animate(withDuration: 0.5, animations: {
                self.label.alpha = 1.0
                self.gameBg.alpha = 1.0
                self.progressBar.alpha = 1.0
                
                for subview in self.gameBg.subviews {
                    subview.alpha = 1.0
                }
            })
        }
    }
    
    func fadeOutElements() {
        generateText()
        UIView.animate(withDuration: 0.5, animations: {
            // Set the alpha of elements to 0.0 for a fade-out effect
            self.progressBar.alpha = 0.0
            self.label.alpha = 0.0
            self.gameBg.alpha = 0.0
        }){ _ in
            self.progressBar.removeFromSuperview()
            self.label.removeFromSuperview()
            self.gameBg.removeFromSuperview()
            // After fade-out animation completes, set the alpha of overlayBg to 1.0 with fadeIn animation
            UIView.animate(withDuration: 0.5, animations: {
                self.overlayBg.alpha = 1.0
                self.warningView.alpha = 1.0
                self.warningLabel.alpha = 1.0
                self.warningButton.alpha = 1.0
                self.warningMessage.alpha = 1.0
                self.buttonText.alpha = 1.0
                self.divider.alpha = 1.0
            })
        }
        
    }
    
    @objc func startGameElements(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            // Set the alpha of elements to 0.0 for a fade-out effect
            self.infoView.alpha = 0.0
            self.infoImage.alpha = 0.0
            self.infoLabel.alpha = 0.0
            self.infoButton.alpha = 0.0
            self.infoOverlayBg.alpha = 0.0
            self.infoButtonText.alpha = 0.0
            self.infoMessage.alpha = 0.0
            self.skipButton.alpha = 0.0
            self.skipButtonText.alpha = 0.0
        }){ _ in
            self.infoView.removeFromSuperview()
            self.infoImage.removeFromSuperview()
            self.infoLabel.removeFromSuperview()
            self.infoButton.removeFromSuperview()
            self.infoOverlayBg.removeFromSuperview()
            self.infoButtonText.removeFromSuperview()
            self.infoMessage.removeFromSuperview()
            self.skipButton.removeFromSuperview()
            self.skipButtonText.removeFromSuperview()
            // After fade-out animation completes, set the alpha of overlayBg to 1.0 with fadeIn animation
            UIView.animate(withDuration: 0.5, animations: {
                self.countDownTimer.alpha = 1.0
                self.countDownLabel.alpha = 1.0
                self.countDownTopLabel.alpha = 1.0
            })
        }
        startTimer()
    }
    
    func startTimer(){
        countDownTimer.startCountdown()
        initialCountTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        isGameStarting = true
    }
    
    func generateText(){
        if isStimulateGame{
            if wrongSwipe <= 3{
                warningLabel.text = "Impressive!"
                warningMessage.text = "Excellent progress! Your focus mode is just a click away~"
            }else if wrongSwipe <= 10{
                warningLabel.text = "Awesome!"
                warningMessage.text = "You've nailed it! Now, time to switch on your focus mode!"
            }else if wrongSwipe > 10{
                warningLabel.text = "Great!"
                warningMessage.text = "You seem to be focused! Ready for your study session?"
            }
        }else{
            if wrongSwipe <= 3{
                warningLabel.text = "Impressive!"
                warningMessage.text = "Wrong Swipe : \(wrongSwipe)"
            }else if wrongSwipe <= 5{
                warningLabel.text = "Awesome!"
                warningMessage.text = "Wrong Swipe : \(wrongSwipe)"
            }else if wrongSwipe <= 10{
                warningLabel.text = "Great!"
                warningMessage.text = "Wrong Swipe : \(wrongSwipe)"
            }else{
                warningLabel.text = "Hmmm..."
                warningMessage.text = "Too many wrong swipe bro\nWrong Swipe : \(wrongSwipe)"
            }
        }
        
    }
    
    //Game Logic Starts Below
    private func generateRandomArrow() {
        let arrows = ["DownGreen", "DownRed", "UpRed", "UpGreen", "LeftRed", "LeftGreen", "RightRed", "RightGreen"]
        var randomArrow = arrows.randomElement()!
        
        if randomArrow == previousArrow{
            randomArrow = arrows.randomElement()!
        }
        
        previousArrow = randomArrow
        arrowDirection = randomArrow
        arrowImage.image = UIImage(named: randomArrow)
    }
    
    private func setupGestures() {
        let swipeDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in swipeDirections {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipe.direction = direction
            arrowImage.addGestureRecognizer(swipe)
        }
        arrowImage.isUserInteractionEnabled = true
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        let swipeLocation = sender.location(in: arrowImage)
        
        if arrowImage.bounds.contains(swipeLocation) {
            var correctSwipeDirection: UISwipeGestureRecognizer.Direction
            
            switch arrowDirection {
            case "UpRed", "DownGreen":
                correctSwipeDirection = .down
            case "DownRed", "UpGreen":
                correctSwipeDirection = .up
            case "LeftRed", "RightGreen":
                correctSwipeDirection = .right
            case "RightRed", "LeftGreen":
                correctSwipeDirection = .left
            default:
                correctSwipeDirection = .up
            }
            
            if sender.direction == correctSwipeDirection {
                if gameLevel <= 13 {
                    print("Correct Swipe")
                    print(gameLevel)
                    generateRandomArrow()
                    progressBar.updateSwipeBar()
                    gameLevel += 1
                }else{
                    fadeOutElements()
                    gameLevel = 1
                    isGameStarting = false
                }
            } else {
                print("Wrong Swipe")
                wrongSwipe += 1
                shakeAnimation()
                feedbackGenerator.notificationOccurred(.warning)
            }
        }
    }
    
    private func shakeAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: arrowImage.center.x - 10, y: arrowImage.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: arrowImage.center.x + 10, y: arrowImage.center.y))
        arrowImage.layer.add(shakeAnimation, forKey: "shake")
    }
    
    //Setup Constraint
    func setupLayout(){
        NSLayoutConstraint.activate([
            
            //Label Constraint
            label.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: isiPhoneSE ? 10 : 40),
            label.heightAnchor.constraint(equalToConstant: 80),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            //Warning Rectangle Constraint
            warningView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            warningView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.28),
            warningView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            //Overlay Background Constraint
            overlayBg.topAnchor.constraint(equalTo: view.topAnchor),
            overlayBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Info Overlay Background Constraint
            infoOverlayBg.topAnchor.constraint(equalTo: view.topAnchor),
            infoOverlayBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoOverlayBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoOverlayBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Divider constraint
            divider.heightAnchor.constraint(equalToConstant: 2),
            divider.leadingAnchor.constraint(equalTo: warningView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: warningView.trailingAnchor, constant: -20),
            divider.topAnchor.constraint(lessThanOrEqualTo: warningLabel.bottomAnchor, constant: 15),
            
            //Warning Label Constraint
            warningLabel.topAnchor.constraint(lessThanOrEqualTo: warningView.topAnchor, constant: 35),
            warningLabel.centerXAnchor.constraint(equalTo: warningView.centerXAnchor),
            
            //Warning Message Constraint
            warningMessage.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            warningMessage.leadingAnchor.constraint(equalTo: warningView.leadingAnchor, constant: 25),
            warningMessage.trailingAnchor.constraint(equalTo: warningView.trailingAnchor, constant: -25),
            
            //Warning Button Constraint
            warningButton.topAnchor.constraint(equalTo: warningMessage.bottomAnchor, constant: 25),
            warningButton.widthAnchor.constraint(equalTo: warningView.widthAnchor, multiplier: 0.6),
            warningButton.centerXAnchor.constraint(equalTo: warningView.centerXAnchor),
            warningButton.bottomAnchor.constraint(equalTo: warningView.bottomAnchor, constant: -30),
            
            //Warning button text constraint
//            buttonText.topAnchor.constraint(equalTo: warningButton.topAnchor, constant: isStimulateGame ? 5 : 18),
            buttonText.centerXAnchor.constraint(equalTo: warningButton.centerXAnchor),
            buttonText.centerYAnchor.constraint(equalTo: warningButton.centerYAnchor, constant: -3),
            
            //Info Rectangle Constraint
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: isiPhoneSE ? 0.54 : 0.46),
            infoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            //info image constraint
            infoImage.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 15),
            infoImage.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            infoImage.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            infoImage.heightAnchor.constraint(lessThanOrEqualToConstant: isiPhoneSE ? 250 : 300),
            
            //Info Message constraint
            infoMessage.topAnchor.constraint(equalTo: infoImage.bottomAnchor, constant: 30),
            infoMessage.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 25),
            infoMessage.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -25),
            infoMessage.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: isiPhoneSE ? -18 : -24),
            
            //Info Label Constraint
            infoLabel.bottomAnchor.constraint(equalTo: infoView.topAnchor, constant: -20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65),
            
            //Warning Button Constraint
            infoButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 30),
            infoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //Warning button text constraint
            infoButtonText.topAnchor.constraint(equalTo: infoButton.topAnchor, constant: 5),
            infoButtonText.centerXAnchor.constraint(equalTo: infoButton.centerXAnchor),
            
            //Skip Button Constraint
            skipButton.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 20),
            skipButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //Skip button text constraint
            skipButtonText.topAnchor.constraint(equalTo: skipButton.topAnchor, constant: 5),
            skipButtonText.centerXAnchor.constraint(equalTo: skipButton.centerXAnchor),
            
            //Main Background Constraint
            mainBg.topAnchor.constraint(equalTo: view.topAnchor),
            mainBg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25),
            
            //Countdown View Constraint
            countDownTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //Countdown Label Constraint
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //Countdown Top Label Constraint
            countDownTopLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownTopLabel.bottomAnchor.constraint(equalTo: countDownLabel.topAnchor, constant: -130),
            
            //Progress bar Constraint
            progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: isiPhoneSE ? 40 : 65),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            progressBar.heightAnchor.constraint(equalToConstant: 25),
            
            //Game position constraint
            gameBg.topAnchor.constraint(equalTo: label.bottomAnchor, constant: isiPhoneSE ? 15 : 30),
            gameBg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: isiPhoneSE ? 20 : 40),
            gameBg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: isiPhoneSE ? -20 : -40),
            gameBg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: isiPhoneSE ? -80 : -150),
            
            //Arrow Image constraint
            arrowImage.centerXAnchor.constraint(equalTo: gameBg.centerXAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: gameBg.centerYAnchor, constant: -40),
            arrowImage.heightAnchor.constraint(lessThanOrEqualTo: gameBg.heightAnchor, multiplier: 0.5),
            arrowImage.widthAnchor.constraint(lessThanOrEqualTo: gameBg.widthAnchor, multiplier: 0.68),
        ])
    }
}
