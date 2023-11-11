//
//  HomeViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 17/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let countDownTimer = CountdownRingView()
    var timer: Timer?
    private var showInfo1 = false
    private var showInfo2 = false
    private var focusIsBegin = false
    private var myUserDefault = UserDefaults.standard
    
    private var titleHi : UILabel = {
        let title  = UILabel()
        
        title.text = "Hi, "
        title.layer.zPosition = 8
        title.textColor = UIColor(named: "regular-text")
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowRadius = 0.5
        title.layer.shadowOpacity = 0.1
        title.layer.zPosition = 1
        title.layer.shadowOffset = CGSize(width: 3, height: 3)
        title.layer.masksToBounds = false
        title.font = .rounded(ofSize: 24, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var titleName : UILabel = {
        let title  = UILabel()
        
        title.text = "Player!"
        title.textColor = UIColor(named: "secondaryColor")
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowRadius = 0.5
        title.layer.shadowOpacity = 0.1
        title.layer.zPosition = 1
        title.layer.shadowOffset = CGSize(width: 3, height: 3)
        title.layer.masksToBounds = false
        title.font = .rounded(ofSize: 24, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var titleInfo : UILabel = {
        let title  = UILabel()
        
        title.text = "Ready to fish?  "
        title.textColor = UIColor(named: "regular-text")
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowRadius = 0.5
        title.layer.shadowOpacity = 0.1
        title.layer.zPosition = 1
        title.layer.shadowOffset = CGSize(width: 3, height: 3)
        title.layer.masksToBounds = false
        title.font = .rounded(ofSize: 24, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.layer.zPosition = 1
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var containerLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryColor")?.withAlphaComponent(0.8)
        view.layer.zPosition = 1
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var bgFocus: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "bg-home")
        view.layer.zPosition = 0
        view.contentMode = .scaleAspectFill
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bgCircle : UIView = {
        let circle = UIView()
        circle.layer.backgroundColor =  UIColor(red: 0.831, green: 0.8, blue: 0.624, alpha: 0.4).cgColor
        circle.layer.shadowColor = UIColor.black.cgColor
        circle.layer.shadowRadius = 10
        circle.layer.shadowOpacity = 0.4
        circle.layer.shadowOffset = CGSize(width: 2, height: 5)
        circle.layer.cornerRadius = 81
        circle.translatesAutoresizingMaskIntoConstraints =  false
        
        return circle
        
    }()
    
    private var innerCircle : UIView = {
        let circle = UIView()
        circle.clipsToBounds = true
        circle.layer.backgroundColor = UIColor(red: 0.831, green: 0.8, blue: 0.624, alpha: 0.6).cgColor
        circle.layer.cornerRadius = 64
        circle.translatesAutoresizingMaskIntoConstraints =  false
        
        return circle
        
    }()
    
    private var btnFocus: UIButton = {
        
        let btn =  UIButton()
        btn.setTitle("Focus", for: .normal)
        btn.layer.backgroundColor = UIColor(red: 0.976, green: 0.902, blue: 0.839, alpha: 1).cgColor
        btn.layer.cornerRadius = 45
        btn.titleLabel?.font = .rounded(ofSize: 20, weight: .bold)
        btn.setTitleColor(UIColor(named: "primaryColor"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
        
    }()
    
    private var userInfoOverlay: ReuseableInfoView = {
        let addLabel = UILabel()
        addLabel.font =  .rounded(ofSize: 18, weight: .bold)
        addLabel.text = "Player"
        
        let view =  ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot1, labelText: "Hey! I’m your friend, Oceano!", position: false, labelTextStyle: .label1)
        view.layer.zPosition = 2
        return view
    }()
    
    private var userInfoOverlay2: ReuseableInfoView = {
        let view =  ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot2, labelText: "“Ready to start? Shrimply tap the ‘Focus’ button to begin your fishing session!”", position: false, labelTextStyle: .label2)
        view.layer.zPosition = 2
        return view
    }()
    
    private var infoIcon: UIButton = {
        let image = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        image.setImage(UIImage(systemName: "info.circle.fill", withConfiguration: largeConfig), for: .normal)
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor(named: "primaryColor")
        image.layer.zPosition = 1
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var btnHistory: UIButton = {
        let image = UIButton(type: .custom)
        image.setImage(UIImage(named: "btn-history"), for: .normal)
        image.tintColor = .white
        image.layer.zPosition = 1
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
        
//        countDownTimer.startIcon = UIImage(named: "icon-fish-loading")
        countDownTimer.translatesAutoresizingMaskIntoConstraints = false
        countDownTimer.layer.zPosition = 10
        countDownTimer.alpha = 0.0
        userInfoOverlay.alpha = 0.0
        userInfoOverlay2.alpha = 0.0

        
        view.addSubview(countDownTimer)
    
        
        NSLayoutConstraint.activate([
            countDownTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
        
        view.addSubview(userInfoOverlay)
    
        NSLayoutConstraint.activate([
            userInfoOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            userInfoOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(userInfoOverlay2)
    
        NSLayoutConstraint.activate([
            userInfoOverlay2.topAnchor.constraint(equalTo: view.topAnchor),
            userInfoOverlay2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoOverlay2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoOverlay2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(containerLabel)
        
        NSLayoutConstraint.activate([
            containerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 103),
            containerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerLabel.widthAnchor.constraint(equalToConstant: 321),
            containerLabel.heightAnchor.constraint(equalToConstant: 81)
        ])
        
        containerLabel.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: containerLabel.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: containerLabel.topAnchor, constant: 10)
        ])
        
        stackView.addArrangedSubview(titleHi)
        stackView.addArrangedSubview(titleName)
        
        containerLabel.addSubview(titleInfo)
        
        NSLayoutConstraint.activate([
            titleInfo.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            titleInfo.centerXAnchor.constraint(equalTo: containerLabel.centerXAnchor, constant: 5)
        ])
        
        view.addSubview(bgFocus)
        
        NSLayoutConstraint.activate([
            bgFocus.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgFocus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgFocus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgFocus.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        
        view.addSubview(bgCircle)
        
        
        NSLayoutConstraint.activate([
            bgCircle.centerXAnchor.constraint(equalTo: bgFocus.centerXAnchor),
            bgCircle.centerYAnchor.constraint(equalTo: bgFocus.centerYAnchor, constant: -50),
            bgCircle.widthAnchor.constraint(equalToConstant: 162),
            bgCircle.heightAnchor.constraint(equalToConstant: 162)
        ])
        
        
        view.addSubview(innerCircle)
        
        NSLayoutConstraint.activate([
            innerCircle.centerXAnchor.constraint(equalTo: bgFocus.centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: bgFocus.centerYAnchor, constant: -50),
            innerCircle.widthAnchor.constraint(equalToConstant: 128),
            innerCircle.heightAnchor.constraint(equalToConstant: 128)
        ])
        
        view.addSubview(btnFocus)
        
        NSLayoutConstraint.activate([
            btnFocus.centerXAnchor.constraint(equalTo: bgFocus.centerXAnchor),
            btnFocus.centerYAnchor.constraint(equalTo: bgFocus.centerYAnchor, constant: -50),
            btnFocus.widthAnchor.constraint(equalToConstant: 90),
            btnFocus.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        view.addSubview(btnHistory)
        
        NSLayoutConstraint.activate([
            btnHistory.topAnchor.constraint(equalTo: containerLabel.bottomAnchor, constant: 12),
            btnHistory.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        btnFocus.addTarget(self, action: #selector(focusStart), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        
        if ((myUserDefault.data(forKey: "focusData")?.isEmpty) == nil){
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(startUserInfo), userInfo: nil, repeats: false)
        }else{
            userInfoOverlay.removeFromSuperview()
            userInfoOverlay2.removeFromSuperview()
            focusIsBegin = true
        }
        
        btnHistory.addTarget(self, action: #selector(ShowListFocus), for: .touchUpInside)
       
    }
    
    @objc func ShowListFocus(){
        let vc = ResultListViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func startUserInfo(){
        UIView.animate(withDuration: 0.4, animations: {
            self.userInfoOverlay.alpha = 1.0
        })
    }
    
    @objc func handleTap(_ gesture : UITapGestureRecognizer){
        
        if gesture.state == .ended {
            if showInfo1 == false {
                showInfo1 = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.userInfoOverlay.alpha = 0.0
                })
                
                UIView.animate(withDuration: 0.9, animations: {
                    self.userInfoOverlay2.alpha = 1.0
                })
                focusIsBegin = true
                self.bgCircle.layer.zPosition = 3
                self.innerCircle.layer.zPosition = 3
                self.btnFocus.layer.zPosition = 3
            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.userInfoOverlay2.alpha = 0.0
                })
                    
            }
            
           
        }
    }
    
    @objc func focusStart(){
        
        if focusIsBegin{
            UIView.animate(withDuration: 0.3, animations: {
                self.userInfoOverlay2.alpha = 0.0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.nextScreen()
            }
        }else{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        
    }
    
    func nextScreen(){
        var vc: UIViewController
        
        if ((myUserDefault.data(forKey: "focusData")?.isEmpty) == nil){
            vc = FocusViewController()
        }else{
            vc = randomizeGameController()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func randomizeGameController() -> UIViewController {
        let randomIndex = Int(arc4random_uniform(2))
        
        if randomIndex == 0 {
            return FishColorGameController()
        } else {
            return BubbleGameController()
        }
    }
    
}
