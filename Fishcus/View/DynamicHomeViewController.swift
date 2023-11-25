//
//  DynamicHomeViewController.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 19/11/23.
//

import UIKit
import AVFoundation

class DynamicHomeViewController: UIViewController{
    
    private var getSumFishingData = 0 {
        didSet{
            SetupFinishGuidedTutorial()
        }
    }
    private let isiPhoneSE = UIScreen.main.bounds.height <= 667
    private var myUserDefault = UserDefaults.standard
    private var bgVideo: AVPlayer?
    private var bgVideoLayer: AVPlayerLayer?
    private var scene: String?
    private let quotes = [
        "In the sea of learning, every page is a catch.",
        "Cast your focus wide, reel in knowledge tide.",
        "Fishing for facts, the study rod extracts.",
        "Hooked on education, reeling in success.",
        "Bait curiosity, fish for facts, reel in understanding.",
        "Every chapter is a lure, every lesson, a catch to secure."
    ]
    
    
    //MARK: - View Variable Declaration
    //Background video layer
    lazy var bgVideoPlayer: UIView = {
        let view = UIView()
        view.layer.zPosition = -100
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Temporary video layer
    lazy var tempBgVideo: UIView = {
        let view = UIView()
        view.layer.zPosition = -100
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //View background
    lazy var mainBg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage.staticHomeBg.day
        bg.contentMode = .scaleAspectFill
        bg.layer.zPosition = -999
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        return bg
    }()
    
    //Label view
    lazy var labelOne: UILabel = {
        let label = UILabel()
        label.text = "Hi Fisher!"
        label.textColor = UIColor.MyColors.regularText
        label.layer.shadowColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.1
        label.layer.zPosition = 2
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        label.font = .rounded(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Label view
    lazy var labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Ready to Fish?"
        label.textColor = UIColor.MyColors.regularText
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
    
    //Focus Button
    lazy var focusEclipse: UIImageView = {
        let circle = UIImageView()
        circle.image = UIImage.focusButton.eclipse
        circle.contentMode = .scaleAspectFill
        circle.layer.zPosition = 1
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        return circle
    }()
    
    lazy var focusButton: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.focusButton.focusButton, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 12
        circleButton.isUserInteractionEnabled = true
        circleButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        
        return circleButton
    }()
    
    //Quotes Rectangle
    lazy var quotesRectangle: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.MyColors.primaryColor
        rectangle.layer.zPosition = 1
        rectangle.layer.cornerRadius = 20
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        return rectangle
    }()
    
    lazy var quotesText: UILabel = {
        let label = UILabel()
        label.text = "In the sea of learning, every page is a catch."
        label.textColor = UIColor.MyColors.regularText
        label.textAlignment = .center
        label.font = .rounded(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var quotesTitleRectangle: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = UIColor.MyColors.regularText
        rectangle.layer.zPosition = 2
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
        return rectangle
    }()
    
    lazy var quotesTitleRectangleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.icons.quotesIcon
        image.contentMode = .scaleAspectFill
        image.layer.zPosition = 2
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var quotesTitleRectangleText: UILabel = {
        let label = UILabel()
        label.text = "Today’s Quotes"
        label.textColor = UIColor.MyColors.primaryColor
        label.textAlignment = .center
        label.font = .rounded(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Change background button
    lazy var dynamicButtonOne: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.dynamicButton.day, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 10
        circleButton.layer.shadowColor = UIColor.black.cgColor
        circleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        circleButton.layer.shadowRadius = 4
        circleButton.layer.shadowOpacity = 0.5
        circleButton.layer.masksToBounds = false
        circleButton.addTarget(self, action: #selector(dynamicButtonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var dynamicButtonTwo: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.dynamicButton.evening, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 10
        circleButton.layer.shadowColor = UIColor.black.cgColor
        circleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        circleButton.layer.shadowRadius = 4
        circleButton.layer.shadowOpacity = 0.5
        circleButton.layer.masksToBounds = false
        circleButton.addTarget(self, action: #selector(dynamicButtonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var dynamicButtonThree: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.dynamicButton.night, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 10
        circleButton.layer.shadowColor = UIColor.black.cgColor
        circleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        circleButton.layer.shadowRadius = 4
        circleButton.layer.shadowOpacity = 0.5
        circleButton.layer.masksToBounds = false
        circleButton.addTarget(self, action: #selector(dynamicButtonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var guidedTutorials: [ReuseableInfoView] = [
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot1, labelText: "Hey! I’m your friend, Oceano! Let's explore this app together, shall we?", position: true, labelTextStyle: .label1),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot1, labelText: "Ready to start? Shrimply tap the ‘Focus’ button to begin your fishing session!", position: false, labelTextStyle: .label2)
    ]
    
    lazy var finishGuidedTutorial =  ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot3, labelText: "Congrats! You are now ready to start your fishing journey and reel in those precious fish of knowledge!", position: true, labelTextStyle: .label1)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the subviews
        subviews()
        
        //Calling the constraint
        setupView()
        
        //Setup Background base on time of the day
        setBackgroundBasedOnTime()
        
        //Setup guided
        SetupGuidedTutorial()
        
        //Update quotes
        setupDailyQuoteUpdateTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        countSumFishingData()
        bgVideo?.play()
    }
    
    func countSumFishingData() {
        getSumFishingData = GetDataFishing.getData().count
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the video when the view disappears
        bgVideo?.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        quotesTitleRectangle.layer.cornerRadius = quotesTitleRectangle.frame.height / 2
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - View functionality
    @objc func appDidEnterBackground() {
        bgVideo?.pause()
    }

    @objc func appWillEnterForeground() {
        bgVideo?.play()
    }
    
    @objc func nextScreen(){
        var vc: UIViewController
        
        vc = SetupFocusViewController()
        
        vc.hidesBottomBarWhenPushed = true
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func subviews(){
        view.addSubview(bgVideoPlayer)
        view.addSubview(tempBgVideo)
        view.addSubview(mainBg)
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        
        view.addSubview(dynamicButtonOne)
        view.addSubview(dynamicButtonTwo)
        view.addSubview(dynamicButtonThree)
        
        view.addSubview(focusButton)
        
        view.addSubview(focusEclipse)
        view.addSubview(quotesRectangle)
        view.addSubview(quotesTitleRectangle)
        
        quotesRectangle.addSubview(quotesText)
        
        quotesTitleRectangle.addSubview(quotesTitleRectangleImage)
        quotesTitleRectangle.addSubview(quotesTitleRectangleText)
        
    }
    
    
    //MARK: - Logics
    func setupBackgroundLayerVideo(withVideoNamed videoName: String) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mov") else {
            print("Video file not found")
            return
        }
        
        // Remove old video layer if one exists
        bgVideoLayer?.removeFromSuperlayer()
        
        bgVideo = AVPlayer(url: URL(fileURLWithPath: path))
        bgVideoLayer = AVPlayerLayer(player: bgVideo)
        bgVideoLayer?.frame = self.view.bounds
        bgVideoLayer?.videoGravity = .resizeAspectFill
        self.view.layer.insertSublayer(bgVideoLayer!, at: 0) 
        bgVideo?.play()
        bgVideo?.actionAtItemEnd = .none
        
        // Loop video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.bgVideo?.currentItem, queue: .main) { [weak self] _ in
            self?.bgVideo?.seek(to: CMTime.zero)
            self?.bgVideo?.play()
        }
    }
    
    //Buttons sets background image function
    @objc func dynamicButtonTapped(_ sender: UIButton) {
        if sender == dynamicButtonOne {
            updateButtonStates(scenes: "Day")
            dynamicButtonOne.setImage(UIImage.dynamicButton.day, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.eveningActive, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.nightActive, for: .normal)
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenDay")
            mainBg.image = UIImage.staticHomeBg.day
        } else if sender == dynamicButtonTwo {
            updateButtonStates(scenes: "Evening")
            dynamicButtonOne.setImage(UIImage.dynamicButton.dayActive, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.evening, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.nightActive, for: .normal)
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenEvening")
            mainBg.image = UIImage.staticHomeBg.evening
        } else if sender == dynamicButtonThree {
            updateButtonStates(scenes: "Night")
            dynamicButtonOne.setImage(UIImage.dynamicButton.dayActive, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.eveningActive, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.night, for: .normal)
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenNight")
            mainBg.image = UIImage.staticHomeBg.night
        }
    }
    
    // Setup guided tutorial for first time user
    func SetupGuidedTutorial(){
        if(myUserDefault.data(forKey: "focusData")?.isEmpty == nil){
            let initialGuidedTutorial = guidedTutorials[0]
            initialGuidedTutorial.layer.zPosition = 999
            
            view.addSubview(initialGuidedTutorial)
            
            NSLayoutConstraint.activate([
                initialGuidedTutorial.topAnchor.constraint(equalTo: view.topAnchor),
                initialGuidedTutorial.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                initialGuidedTutorial.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                initialGuidedTutorial.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeGuidedTutorial(_:)))
            initialGuidedTutorial.addGestureRecognizer(tapGesture)
        }
      
    }
    
    func SetupFinishGuidedTutorial(){
        if(getSumFishingData == 1){
            let initialFinishTutorial = finishGuidedTutorial
            initialFinishTutorial.layer.zPosition = 999
            
            view.addSubview(initialFinishTutorial)
            
            NSLayoutConstraint.activate([
                initialFinishTutorial.topAnchor.constraint(equalTo: view.topAnchor),
                initialFinishTutorial.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                initialFinishTutorial.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                initialFinishTutorial.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeLastGuided(_:)))
            initialFinishTutorial.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func removeLastGuided(_ gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        currentView.removeFromSuperview()
    }
    
    // change index
    @objc func changeGuidedTutorial(_ gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        currentView.removeFromSuperview()
        
        let nextIndex = (guidedTutorials.firstIndex(of: currentView as! ReuseableInfoView) ?? 0 )+1
        
        if nextIndex < guidedTutorials.count{
            let nextView = guidedTutorials[nextIndex]
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(changeGuidedTutorial(_:)))
            nextView.addGestureRecognizer(gesture)
            
            nextView.layer.zPosition = 10
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
    
    //Background image function
    func setBackgroundBasedOnTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if (8...14).contains(hour) { // 8 AM to 3:30 PM
            updateButtonStates(scenes: "Day")
            mainBg.image = UIImage.staticHomeBg.day
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenDay")
            dynamicButtonOne.setImage(UIImage.dynamicButton.day, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.eveningActive, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.nightActive, for: .normal)
        } else if (15...18).contains(hour) { // 3:30 PM to 7 PM
            updateButtonStates(scenes: "Evening")
            mainBg.image = UIImage.staticHomeBg.evening
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenEvening")
            dynamicButtonOne.setImage(UIImage.dynamicButton.dayActive, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.evening, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.nightActive, for: .normal)
        } else { // 7 PM to 8 AM
            updateButtonStates(scenes: "Night")
            mainBg.image = UIImage.staticHomeBg.night
            setupBackgroundLayerVideo(withVideoNamed: "HomeScreenNight")
            dynamicButtonOne.setImage(UIImage.dynamicButton.dayActive, for: .normal)
            dynamicButtonTwo.setImage(UIImage.dynamicButton.eveningActive, for: .normal)
            dynamicButtonThree.setImage(UIImage.dynamicButton.night, for: .normal)
        }
    }
    
    //Trigger disable button
    func updateButtonStates(scenes: String) {
        scene = scenes
        dynamicButtonOne.isUserInteractionEnabled = scene != "Day"
        dynamicButtonTwo.isUserInteractionEnabled = scene != "Evening"
        dynamicButtonThree.isUserInteractionEnabled = scene != "Night"
    }
    
    //Fungsi update kata kata hari ini bosq
    // Set up a timer to trigger the quote update at midnight
    func setupDailyQuoteUpdateTimer() {
        let calendar = Calendar.current
        let now = Date()
        var nextMidnight = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now)!)
        
        // If the app is launched after midnight but before the first user interaction of the day, update immediately
        if myUserDefault.object(forKey: "lastUpdate") == nil || !calendar.isDateInToday(myUserDefault.object(forKey: "lastUpdate") as! Date) {
            updateQuoteOfTheDay()
            nextMidnight = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: nextMidnight)!)
        }

        let timer = Timer(fireAt: nextMidnight, interval: 0, target: self, selector: #selector(updateQuoteOfTheDay), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }

    // Update the quote
    @objc func updateQuoteOfTheDay() {
        var newQuoteIndex: Int
        repeat {
            newQuoteIndex = Int.random(in: 0..<quotes.count)
        } while newQuoteIndex == myUserDefault.integer(forKey: "lastQuoteIndex")

        DispatchQueue.main.async {
            self.quotesText.text = self.quotes[newQuoteIndex]
        }

        myUserDefault.set(newQuoteIndex, forKey: "lastQuoteIndex")
        myUserDefault.set(Date(), forKey: "lastUpdate")
    }
    
    //MARK: - Constraints
    //Constraints
    func setupView(){
        NSLayoutConstraint.activate([
            //Video layer constraint
            bgVideoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgVideoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgVideoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            bgVideoPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tempBgVideo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tempBgVideo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tempBgVideo.topAnchor.constraint(equalTo: view.topAnchor),
            tempBgVideo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Main Background Constraint
            mainBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBg.topAnchor.constraint(equalTo: view.topAnchor),
            mainBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Label one contraint
            labelOne.topAnchor.constraint(equalTo: view.topAnchor, constant: isiPhoneSE ? 47 : 97),
            labelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: isiPhoneSE ? 15 : 35),
            
            //Label two contraint
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 2),
            labelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: isiPhoneSE ? 15 : 35),
            
            //Quotes rectangle constraint
            quotesRectangle.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: isiPhoneSE ? 135 : 195),
            quotesRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quotesRectangle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            quotesRectangle.heightAnchor.constraint(greaterThanOrEqualToConstant: isiPhoneSE ? 65 : 85),
            
            //Quotes text constraint
            quotesText.topAnchor.constraint(lessThanOrEqualTo: quotesRectangle.topAnchor, constant: 19),
            quotesText.trailingAnchor.constraint(equalTo: quotesRectangle.trailingAnchor, constant: isiPhoneSE ? -25 : -50),
            quotesText.leadingAnchor.constraint(equalTo: quotesRectangle.leadingAnchor, constant: isiPhoneSE ? 25 : 50),
            quotesText.bottomAnchor.constraint(equalTo: quotesRectangle.bottomAnchor, constant: isiPhoneSE ? -12 : -9),
            
            //Quotes rectangle tittle constraint
            quotesTitleRectangle.topAnchor.constraint(equalTo: quotesRectangle.topAnchor, constant: -15),
            quotesTitleRectangle.centerXAnchor.constraint(equalTo: quotesRectangle.centerXAnchor),
            quotesTitleRectangle.widthAnchor.constraint(equalTo: quotesRectangle.widthAnchor, multiplier: 0.43),
            quotesTitleRectangle.heightAnchor.constraint(equalToConstant: 30),
            
            //Quotes rectangle tittle image constraint
            quotesTitleRectangleImage.leadingAnchor.constraint(equalTo: quotesTitleRectangle.leadingAnchor, constant: 4),
            quotesTitleRectangleImage.topAnchor.constraint(equalTo: quotesTitleRectangle.topAnchor, constant: 4),
            quotesTitleRectangleImage.bottomAnchor.constraint(equalTo: quotesTitleRectangle.bottomAnchor, constant: -4),
            
            //Quotes rectangle tittle label constraint
            quotesTitleRectangleText.leadingAnchor.constraint(equalTo: quotesTitleRectangle.leadingAnchor, constant: 26),
            quotesTitleRectangleText.topAnchor.constraint(equalTo: quotesTitleRectangle.topAnchor, constant: 6),
            quotesTitleRectangleText.bottomAnchor.constraint(equalTo: quotesTitleRectangle.bottomAnchor, constant: -6),
            quotesTitleRectangleText.trailingAnchor.constraint(equalTo: quotesTitleRectangle.trailingAnchor, constant: -6),
            
            //Eclipse constraint
            focusEclipse.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusEclipse.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28),
            focusEclipse.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            focusEclipse.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: isiPhoneSE ? -200 : -250),
            
            //Focus Button constraint
            focusButton.centerXAnchor.constraint(equalTo: focusEclipse.centerXAnchor),
            focusButton.centerYAnchor.constraint(equalTo: focusEclipse.centerYAnchor),
            focusButton.heightAnchor.constraint(lessThanOrEqualTo: focusEclipse.heightAnchor, multiplier: isiPhoneSE ? 0.7 : 0.7),
            focusButton.widthAnchor.constraint(lessThanOrEqualTo: focusEclipse.widthAnchor, multiplier: isiPhoneSE ? 0.7 : 0.85),
            
            //Change background 1 constrain
            dynamicButtonOne.trailingAnchor.constraint(greaterThanOrEqualTo: dynamicButtonTwo.leadingAnchor, constant: -32),
            dynamicButtonOne.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -130),
            dynamicButtonOne.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            dynamicButtonOne.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),
            
            //Change background 2 constrain
            dynamicButtonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dynamicButtonTwo.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -130),
            dynamicButtonTwo.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            dynamicButtonTwo.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),
            
            //Change background 3 constrain
            dynamicButtonThree.leadingAnchor.constraint(greaterThanOrEqualTo: dynamicButtonTwo.trailingAnchor, constant: 32),
            dynamicButtonThree.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -130),
            dynamicButtonThree.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            dynamicButtonThree.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),

        ])
    }
}
