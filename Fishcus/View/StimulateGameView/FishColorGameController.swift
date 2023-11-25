//
//  FishColorGameController.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 11/11/23.
//

import Foundation
import UIKit

class FishColorGameController: UIViewController{
    
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
    private var numberOfFishes = 5
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    private var wrongTap = 0
    private let countDownTimer = CountdownRingView()
    private var initialCountValue = 3
    private var initialCountTimer: Timer!
    private var isGameStarting: Bool = false
    private var fishCounts: [String: Int] = ["RedFish": 0, "BlueFish": 0, "GreenFish": 0]
    private var fishTypes = ["RedFish", "BlueFish", "GreenFish"]
    private var fishImageViews = [UIImageView]()
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
        image.image = UIImage(named: "fishGameTutorial")
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
        label.text = "Guess The\nDominant Color!"
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
        label.text = "Choose which color is the\nmost dominant!"
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
    
    //Fish Container
    lazy var fishBg: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.clear
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.alpha = 0.0
        
        return rectangle
    }()
    
    //Fish color Button
    lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-empty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        button.titleLabel?.font = .rounded(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        
        return button
    }()
    
    //Fish color Button
    lazy var buttonTwo: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-empty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        button.titleLabel?.font = .rounded(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        
        return button
    }()
    
    //Fish color Button
    lazy var buttonThree: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-empty"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.zPosition = 1
        button.titleLabel?.font = .rounded(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        
        return button
    }()
    
    //Fish button one Label view
    lazy var buttonOneText: UILabel = {
        let label = UILabel()
        label.text = "Let’s go!"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Fish button two Label view
    lazy var buttonTwoText: UILabel = {
        let label = UILabel()
        label.text = "Let’s go!"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Fish button three Label view
    lazy var buttonThreeText: UILabel = {
        let label = UILabel()
        label.text = "Let’s go!"
        label.textColor = UIColor(named: "primaryColor")
        label.textAlignment = .center
        label.font = .rounded(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Label view
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "What colors do you see the most?"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the subviews
        subviews()
        
        // Initialize the feedback generator
        feedbackGenerator.prepare()
        
        //Call the constraint function
        setupLayout()
        
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
        
        //Game view subviews
        gameBg.addSubview(buttonOne)
        gameBg.addSubview(buttonTwo)
        gameBg.addSubview(buttonThree)
        gameBg.addSubview(fishBg)
        
        //Button fish tittles
        buttonOne.addSubview(buttonOneText)
        buttonTwo.addSubview(buttonTwoText)
        buttonThree.addSubview(buttonThreeText)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        randomizeAndPlaceFishes()
        randomizeButtons()
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
        randomizeAndPlaceFishes()
        randomizeButtons()
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
            if wrongTap <= 3{
                warningLabel.text = "Impressive!"
                warningMessage.text = "Excellent progress! Your focus mode is just a click away~"
            }else if wrongTap <= 10{
                warningLabel.text = "Awesome!"
                warningMessage.text = "You've nailed it! Now, time to switch on your focus mode!"
            }else if wrongTap > 10{
                warningLabel.text = "Great!"
                warningMessage.text = "You seem to be focused! Ready for your study session?"
            }
        }else{
            if wrongTap <= 3{
                warningLabel.text = "Impressive!"
                warningMessage.text = "Wrong Guess : \(wrongTap)"
            }else if wrongTap <= 5{
                warningLabel.text = "Awesome!"
                warningMessage.text = "Wrong Guess : \(wrongTap)"
            }else if wrongTap <= 10{
                warningLabel.text = "Great!"
                warningMessage.text = "Wrong Guess : \(wrongTap)"
            }else{
                warningLabel.text = "Hmmm..."
                warningMessage.text = "Too many wrong guess bro\nWrong Guess : \(wrongTap)"
            }
        }
    }
    
    func setButtonAlpha(){
        buttonOneText.alpha = 0.0
        buttonTwoText.alpha = 0.0
        buttonThreeText.alpha = 0.0
        
        UIView.animate(withDuration: 0.8) {
            self.buttonOneText.alpha = 1.0
            self.buttonTwoText.alpha = 1.0
            self.buttonThreeText.alpha = 1.0
        }
    }
    
    // Define color button actions
    @objc func fishButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        let mostDisplayedFishCount = fishCounts.values.max() ?? 0
        let selectedFishCount = fishCounts[title + "Fish"] ?? 0
        
        if selectedFishCount == mostDisplayedFishCount {
            print("\(title) is the most displayed!")
            numberOfFishes += 1
            gameLevel += 1
            progressBar.updateBar()
            print(gameLevel)
            if gameLevel > 5 {
                isGameStarting = false
                removeAllFish()
                fadeOutElements()
                print(isGameStarting)
            } else {
                removeAllFish()
                randomizeAndPlaceFishes()
                randomizeButtons()
                setButtonAlpha()
            }
        } else {
            print("\(title) is not the most displayed.")
            shakeAnimation()
            feedbackGenerator.notificationOccurred(.warning)
            wrongTap += 1
        }
    }
    
    func removeAllFish() {
        fishImageViews.forEach { $0.removeFromSuperview() }
        fishImageViews.removeAll()
        fishCounts = ["RedFish": 0, "BlueFish": 0, "GreenFish": 0]
    }
    
    func randomizeAndPlaceFishes() {
        // Clear previous fish images and reset counts
        guard isGameStarting else { return }
        removeAllFish()
        
        var placedPositions: [CGPoint] = []
        
        // Determine the color of fish to show the most
        let mostCommonFishColor = fishTypes.randomElement()!
        
        // Set a majority of the fishes to the most common type
        let majorityCount = Int(ceil(Double(numberOfFishes) * 0.6)) // e.g., 60% of total fish
        
        // Assign the majority to the most common fish
        for _ in 0..<majorityCount {
            createAndPlaceFish(ofType: mostCommonFishColor, placedPositions: &placedPositions)
        }
        
        // Distribute the remaining fishes among the other types
        for _ in majorityCount..<numberOfFishes {
            let fishType = fishTypes.filter { $0 != mostCommonFishColor }.randomElement()!
            createAndPlaceFish(ofType: fishType, placedPositions: &placedPositions)
        }
        
        // We need to layout the view now to apply constraints
        fishBg.layoutIfNeeded()
    }
    
    func createAndPlaceFish(ofType fishType: String, placedPositions: inout [CGPoint]) {
        fishCounts[fishType, default: 0] += 1
        
        let fishImage = UIImage(named: fishType)
        let fishImageView = UIImageView(image: fishImage)
        fishImageView.contentMode = .scaleAspectFit
        fishImageView.translatesAutoresizingMaskIntoConstraints = false
        fishImageView.alpha = 0.0
        
        fishBg.addSubview(fishImageView)
        fishImageViews.append(fishImageView)
        
        var fishPosition: CGPoint
        repeat {
            fishPosition = generateRandomPositionForFish()
        } while doesOverlapFish(at: fishPosition, with: placedPositions)
        
        placedPositions.append(fishPosition)
        
        NSLayoutConstraint.activate([
            fishImageView.widthAnchor.constraint(equalTo: fishBg.widthAnchor, multiplier: isiPhoneSE ? 0.2 : 0.3),
            fishImageView.heightAnchor.constraint(equalTo: fishImageView.widthAnchor),
            fishImageView.leadingAnchor.constraint(equalTo: fishBg.leadingAnchor, constant: fishPosition.x),
            fishImageView.topAnchor.constraint(equalTo: fishBg.topAnchor, constant: fishPosition.y)
        ])
        
        UIView.animate(withDuration: 0.8) {
            fishImageView.alpha = 1.0
        }
    }
    
    func generateRandomPositionForFish() -> CGPoint {
        let fishSize = fishBg.bounds.size.width * 0.2
        let maxX = fishBg.bounds.width - fishSize
        let maxY = fishBg.bounds.height - fishSize
        let randomX = CGFloat.random(in: 0...maxX)
        let randomY = CGFloat.random(in: 0...maxY)
        return CGPoint(x: randomX, y: randomY)
    }
    
    func doesOverlapFish(at position: CGPoint, with positions: [CGPoint]) -> Bool {
        let threshold: CGFloat = fishBg.bounds.size.width * 0.2
        for otherPosition in positions {
            if abs(otherPosition.x - position.x) < threshold && abs(otherPosition.y - position.y) < threshold {
                return true
            }
        }
        return false
    }
    
    func randomizeButtons() {
        guard isGameStarting else { return }
        let buttonTitles = ["Red", "Blue", "Green"].shuffled()
        let buttons = [buttonOne, buttonTwo, buttonThree]
        let titles = [buttonOneText, buttonTwoText, buttonThreeText]
        
        // Clear any previous actions to prevent duplicate actions being called
        buttons.forEach { $0.removeTarget(nil, action: nil, for: .allEvents) }
        
        for (index, button) in buttons.enumerated() {
            DispatchQueue.main.async {
                let title = buttonTitles[index]
                button.setTitle(title, for: .normal)
                titles[index].text = title // Ensure this updates the button's visible title
                button.addTarget(self, action: #selector(self.fishButtonTapped(_:)), for: .touchUpInside)
                
                if index != (buttonTitles.count - 1) {
                    titles[index].textColor = UIColor(named: buttonTitles[index+1])
                }else {
                    titles[index].textColor = UIColor(named: buttonTitles[0])
                }
                
            }
        }
        buttonOne.layoutIfNeeded()
        buttonTwo.layoutIfNeeded()
        buttonThree.layoutIfNeeded()
        updateButtonTags(buttons: buttons)
    }
    
    func updateButtonTags(buttons: [UIButton]) {
        // Determine the most displayed fish
        guard let mostDisplayedFish = fishCounts.max(by: { a, b in a.value < b.value })?.key else { return }
        
        // Store the tag in each button to identify the most displayed fish
        for button in buttons {
            if let title = button.currentTitle {
                button.tag = (title + "Fish" == mostDisplayedFish) ? 1 : 0
            } else {
                button.tag = 0
            }
        }
    }
    
    private func shakeAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: gameBg.center.x - 10, y: gameBg.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: gameBg.center.x + 10, y: gameBg.center.y))
        gameBg.layer.add(shakeAnimation, forKey: "shake")
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
            
            //Fish container constraint
            fishBg.topAnchor.constraint(equalTo: gameBg.topAnchor),
            fishBg.leadingAnchor.constraint(equalTo: gameBg.leadingAnchor),
            fishBg.trailingAnchor.constraint(equalTo: gameBg.trailingAnchor),
            fishBg.bottomAnchor.constraint(equalTo: gameBg.bottomAnchor, constant: isiPhoneSE ? -90 : -120),
            
            //Fish Button one Constraints
            buttonOne.bottomAnchor.constraint(equalTo: gameBg.bottomAnchor),
            buttonOne.widthAnchor.constraint(equalTo: gameBg.widthAnchor, multiplier: 0.4),
            buttonOne.heightAnchor.constraint(equalTo: gameBg.heightAnchor, multiplier: 0.1),
            buttonOne.centerXAnchor.constraint(equalTo: gameBg.centerXAnchor),
            
            //Fish Button Two Constraints
            buttonTwo.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: -10),
            buttonTwo.widthAnchor.constraint(equalTo: gameBg.widthAnchor, multiplier: 0.4),
            buttonTwo.leadingAnchor.constraint(equalTo: gameBg.leadingAnchor, constant: 20),
            buttonTwo.heightAnchor.constraint(equalTo: gameBg.heightAnchor, multiplier: 0.1),
            
            //Fish Button Three Constraints
            buttonThree.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: -10),
            buttonThree.widthAnchor.constraint(equalTo: gameBg.widthAnchor, multiplier: 0.4),
            buttonThree.trailingAnchor.constraint(equalTo: gameBg.trailingAnchor, constant: -20),
            buttonThree.heightAnchor.constraint(equalTo: gameBg.heightAnchor, multiplier: 0.1),
            
            //Fish button one text constraint
            buttonOneText.topAnchor.constraint(equalTo: buttonOne.topAnchor, constant: 10),
            buttonOneText.bottomAnchor.constraint(equalTo: buttonOne.bottomAnchor, constant: -15),
            buttonOneText.centerXAnchor.constraint(equalTo: buttonOne.centerXAnchor),
            
            //Fish button two text constraint
            buttonTwoText.topAnchor.constraint(equalTo: buttonTwo.topAnchor, constant: 10),
            buttonTwoText.bottomAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: -15),
            buttonTwoText.centerXAnchor.constraint(equalTo: buttonTwo.centerXAnchor),
            
            //Fish button three constraint
            buttonThreeText.topAnchor.constraint(equalTo: buttonThree.topAnchor, constant: 10),
            buttonThreeText.bottomAnchor.constraint(equalTo: buttonThree.bottomAnchor, constant: -15),
            buttonThreeText.centerXAnchor.constraint(equalTo: buttonThree.centerXAnchor),
        ])
    }
    
}

