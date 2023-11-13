//
//  ResultViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 26/10/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var loadingView: UIView?
    
    var time: String?
    var activity: String?
    var fish: String?
    var rare: String?
    var focusData: [[String: String]] = []
    
    init(time: String, activity: String, fish: String, rare: String) {
        self.time = time
        self.activity = activity
        self.fish = fish
        self.rare = rare
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingView() {
        loadingView = UIView(frame: self.view.bounds)
        loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.5)

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView!.center
        loadingView?.addSubview(activityIndicator)

        self.view.addSubview(loadingView!)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    let myBgImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg-result")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let fishImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 2, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var resultBtn: UIButton = {
        let image = UIButton(type: .custom)
        image.setImage(UIImage(named: "btn-share"), for: .normal)
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var containerBtnDone: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var doneBtn: UIButton = {
        let button =  UIButton(type: .custom)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.rounded(ofSize: 15, weight: .bold)
        button.backgroundColor = UIColor(named: "primaryColor")
        button.layer.cornerRadius = 13
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var labelSmall: UILabel = {
        var view = UILabel()
        let myUserDefault = UserDefaults.standard
        view.frame = CGRect(x: 0, y: 0, width: 258, height: 19)
        view.textColor = UIColor(red: 0.976, green: 0.902, blue: 0.839, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        // Line height: 19.09 pt
        // (identical to box height)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var labelBig: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 245, height: 38)
        view.textColor = UIColor(red: 0.976, green: 0.902, blue: 0.839, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        // Line height: 38.19 pt
        view.textAlignment = .center
        view.text = "Betta, the Duelist!"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var waterSplahs1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "water-splash2")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var waterSplahs2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "water-splash1")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var gradientContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 400))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var rectangleRarerity: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var labelRarerity: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 12 , weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var gradientBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.265, green: 0.471, blue: 0.617, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private var userGuideInfo: [ReuseableInfoView] = [
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot4, labelText: "“Cheers to your study milestone! The duration you study will determine the variety of fish you can catch. Keep studying to fill your aquarium!”", position: false, labelTextStyle: .label12),
        ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot4, labelText: "\" Share your latest adventure – your friends are waiting to hear!\" ", position: false, labelTextStyle: .label13)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "result-color")
        self.navigationItem.hidesBackButton = true
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientContainer.bounds
        gradientContainer.layer.insertSublayer(gradient, at: 0)
        
        
        labelSmall.alpha = 0.0
        labelBig.alpha = 0.0
        doneBtn.alpha = 0.0
        resultBtn.alpha = 0.0
        gradientContainer.alpha = 0.0
        gradientBackground.alpha = 0.0
        labelRarerity.alpha =  0.0
        rectangleRarerity.alpha = 0.0
        
        
        switch rare{
        case "C" :
            gradient.colors = [UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0).cgColor,
                               UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1).cgColor]
            self.gradientBackground.backgroundColor = UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1)
            self.labelRarerity.text = "COMMON"
            self.labelRarerity.textColor = UIColor(named: "pale-green")
            self.rectangleRarerity.layer.borderColor = UIColor(named: "pale-green")?.cgColor
            switch fish{
            case "1":
                self.labelBig.text = "Swordfish, the Warrior!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "c")-sword")
                break
            case "2":
                self.labelBig.text = "Clownfish, the Trickster!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "c")-clown")
            default:
                self.labelBig.text = "Betta, the Duelist!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "c")-beta")
                break
            }
            
            break
        case "R":
            gradient.colors = [UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0).cgColor,
                               UIColor(red: 0.265, green: 0.471, blue: 0.617, alpha: 1).cgColor]
            self.gradientBackground.backgroundColor = UIColor(red: 0.265, green: 0.471, blue: 0.617, alpha: 1)
            self.labelRarerity.text = "RARE"
            self.labelRarerity.textColor = UIColor(named: "secondaryColor")
            self.rectangleRarerity.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
            switch fish{
            case "1":
                self.labelBig.text = "Swordfish, the Warrior!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "r")-sword")
                break
            case "2":
                self.labelBig.text = "Clownfish, the Trickster!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "r")-clown")
            default:
                self.labelBig.text = "Betta, the Duelist!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "r")-beta")
                break
            }
            
            break
        case "N":
            gradient.colors = [UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0).cgColor,
                               UIColor(red: 0.596, green: 0.137, blue: 0.251, alpha: 1).cgColor]
            self.gradientBackground.backgroundColor = UIColor(red: 0.596, green: 0.137, blue: 0.251, alpha: 1)
            self.labelRarerity.text = "NEPTUNIAN"
            self.labelRarerity.textColor = UIColor(named: "rare-color")
            self.labelBig.textColor = UIColor(named: "rare-color")
            self.rectangleRarerity.layer.borderColor = UIColor(named: "rare-color")?.cgColor
            switch fish{
            case "1":
                self.labelBig.text = "Swordfish, the Warrior!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "n")-sword")
                break
            case "2":
                self.labelBig.text = "Clownfish, the Trickster!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "n")-clown")
            default:
                self.labelBig.text = "Betta, the Duelist!"
                self.fishImage.image = UIImage(named: "\(rare?.lowercased() ?? "n")-beta")
                break
            }
            break
        default :
            gradient.colors = [UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0).cgColor,
                               UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1).cgColor]
            self.gradientBackground.backgroundColor = UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1)
            self.rectangleRarerity.layer.borderColor = UIColor.clear.cgColor
            self.labelBig.text = "Nothing :("
            self.fishImage.image = UIImage(named: "nothing-img")
    
            break
            
        }
        
        view.addSubview(myBgImage)
        
        NSLayoutConstraint.activate([
            myBgImage.topAnchor.constraint(equalTo: view.topAnchor),
            myBgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myBgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myBgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(fishImage)
        
        NSLayoutConstraint.activate([
            fishImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            fishImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fishImage.widthAnchor.constraint(equalToConstant: 380),
            fishImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(waterSplahs1)
        
        NSLayoutConstraint.activate([
            waterSplahs1.topAnchor.constraint(equalTo: fishImage.bottomAnchor, constant: -220),
            waterSplahs1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            waterSplahs1.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(waterSplahs2)
        
        NSLayoutConstraint.activate([
            waterSplahs2.topAnchor.constraint(equalTo: fishImage.bottomAnchor, constant: -150),
            waterSplahs2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            waterSplahs2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(gradientBackground)
        
        NSLayoutConstraint.activate([
            gradientBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientBackground.widthAnchor.constraint(equalToConstant: 450),
            gradientBackground.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(gradientContainer)
        
        NSLayoutConstraint.activate([
            gradientContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientContainer.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        view.addSubview(labelSmall)
        labelSmall.text = "For \(self.time ?? "") minutes of \(self.activity ?? ""), I caught"
        
        NSLayoutConstraint.activate([
            labelSmall.topAnchor.constraint(equalTo: fishImage.bottomAnchor, constant: 100),
            labelSmall.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(labelBig)
        
        NSLayoutConstraint.activate([
            labelBig.topAnchor.constraint(equalTo: labelSmall.bottomAnchor, constant: 10),
            labelBig.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(rectangleRarerity)
        
        NSLayoutConstraint.activate([
            rectangleRarerity.topAnchor.constraint(equalTo: labelBig.bottomAnchor, constant: 10),
            rectangleRarerity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleRarerity.widthAnchor.constraint(equalToConstant: 99),
            rectangleRarerity.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        rectangleRarerity.addSubview(labelRarerity)
        
        NSLayoutConstraint.activate([
            labelRarerity.centerXAnchor.constraint(equalTo: rectangleRarerity.centerXAnchor),
            labelRarerity.centerYAnchor.constraint(equalTo: rectangleRarerity.centerYAnchor)
        ])
        
        view.addSubview(resultBtn)
        
        NSLayoutConstraint.activate([
            resultBtn.topAnchor.constraint(equalTo: rectangleRarerity.bottomAnchor, constant: 27),
            resultBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(containerBtnDone)
        
        NSLayoutConstraint.activate([
            containerBtnDone.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            containerBtnDone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            containerBtnDone.widthAnchor.constraint(equalToConstant: 100),
            containerBtnDone.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerBtnDone.addSubview(doneBtn)
   
        NSLayoutConstraint.activate([
            doneBtn.centerXAnchor.constraint(equalTo: containerBtnDone.centerXAnchor),
            doneBtn.centerYAnchor.constraint(equalTo: containerBtnDone.centerYAnchor),
            doneBtn.widthAnchor.constraint(equalToConstant: 77),
            doneBtn.heightAnchor.constraint(equalToConstant: 31)
        ])
      
        resultBtn.addTarget(self, action: #selector(shareResult), for: .touchUpInside)
        doneBtn.addTarget(self, action: #selector(finish), for: .touchUpInside)
        animate()
        loadData()
        
    }
    
    @objc func guideTapGesture(gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        currentView.removeFromSuperview()
        
        let nextIndex = (userGuideInfo.firstIndex(of: currentView as! ReuseableInfoView) ?? 0 )+1
        
        if nextIndex < userGuideInfo.count{
            let nextView = userGuideInfo[nextIndex]
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(guideTapGesture))
            nextView.addGestureRecognizer(gesture)
            resultBtn.layer.zPosition = 6
            
            nextView.layer.zPosition = 5
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
    
    func loadData() {
        let myUserDefault = UserDefaults.standard
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            focusData = decodedData
        }
    }
    
    @objc func finish(){
        self.navigationController?.pushViewController(ResultListViewController(), animated: true)
    }
    
    
    func animate(){
        UIView.animate(withDuration: 2.3, animations: {
            self.myBgImage.layer.position = CGPoint(x: 0, y: 1000)
            self.waterSplahs1.layer.position = CGPoint(x: 0, y: -1000)
            self.waterSplahs2.layer.position = CGPoint(x: 0, y: -1000)
        })
        
        UIView.animate(withDuration: 3.6, animations: {
            self.fishImage.layer.position = CGPoint(x: 0, y: -1000)
        }, completion: { done in
            
            if done{
                UIView.animate(withDuration: 1.0, animations: {
                    self.labelSmall.alpha = 1.0
                    self.labelBig.alpha = 1.0
                    self.doneBtn.alpha = 1.0
                    self.resultBtn.alpha = 1.0
                    self.gradientContainer.alpha = 1.0
                    self.gradientBackground.alpha = 1.0
                    self.labelRarerity.alpha = 1.0
                    self.rectangleRarerity.alpha = 1.0 
                    
                    if self.focusData.count <= 1{
                        let initialShowInfo = self.userGuideInfo[0]
                        initialShowInfo.layer.zPosition = 5
                        
                        self.view.addSubview(initialShowInfo)
                        
                        NSLayoutConstraint.activate([
                            initialShowInfo.topAnchor.constraint(equalTo: self.view.topAnchor),
                            initialShowInfo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                            initialShowInfo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                            initialShowInfo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                        ])
                        
                        let guideInfoGestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.guideTapGesture))
                        initialShowInfo.isUserInteractionEnabled = true
                        initialShowInfo.addGestureRecognizer(guideInfoGestureRecog)
                    }
                })
               
               
            }
            
        })
    }
    
    func captureScreen(of viewController: UIViewController) -> UIImage? {
        let layer = viewController.view.layer
        let size = layer.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @objc func shareResult(theButton: [UIButton]){
        if let image = captureScreen(of: ShareResultViewController(time: "\(self.time ?? "")", activity: "\(self.activity ?? "")", fish: "\(self.fish ?? "")", rare: "\(self.rare ?? "")")) {
            showLoadingView()
            DispatchQueue.global(qos: .userInitiated).async {
                   let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                // Exclude activities that don't make sense for Instagram
                    activityViewController.excludedActivityTypes = [
                        UIActivity.ActivityType.assignToContact,
                        UIActivity.ActivityType.addToReadingList,
                        UIActivity.ActivityType.airDrop,
                        UIActivity.ActivityType.mail,
                        UIActivity.ActivityType.message,
                        UIActivity.ActivityType.openInIBooks,
                        UIActivity.ActivityType.postToVimeo,
                        UIActivity.ActivityType.postToTencentWeibo,
                        UIActivity.ActivityType.postToWeibo,
                        UIActivity.ActivityType.print,
                    ]

                   // Switch back to the main thread to present the view controller
                   DispatchQueue.main.async {
                       // Dismiss the loading view
                       self.hideLoadingView()

                       self.present(activityViewController, animated: true, completion: nil)
                   }
               }
        }
    }
    

}
