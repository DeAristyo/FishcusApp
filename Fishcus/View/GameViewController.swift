//
//  GameViewController.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 18/11/23.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - View Variable Declaration
    //View background
    lazy var mainBg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage.viewBackgrounds.gameScreenBg
        bg.contentMode = .scaleAspectFill
        bg.layer.zPosition = -999
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        return bg
    }()
    
    lazy var colorButton: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.button.colorGame, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 12
        circleButton.isUserInteractionEnabled = true
        circleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var bubbleButton: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.button.bubblesGame, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 12
        circleButton.isUserInteractionEnabled = true
        circleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var swipeButton: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage.button.swipeGame, for: .normal)
        circleButton.backgroundColor = .clear
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.layer.zPosition = 12
        circleButton.isUserInteractionEnabled = true
        circleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return circleButton
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "...and more to come!"
        label.textColor = UIColor.MyColors.primaryColor
        label.textAlignment = .center
        label.font = .rounded(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the subviews
        subviews()
        
        //Calling the constraints
        setupView()
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.rounded(ofSize: 28, weight: .heavy),
            .foregroundColor: UIColor.MyColors.primaryColor
        ]
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = "Mini-Games"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func subviews(){
        view.addSubview(mainBg)
        view.addSubview(colorButton)
        view.addSubview(bubbleButton)
        view.addSubview(swipeButton)
        view.addSubview(bottomLabel)
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        var vc : UIViewController
        
        if sender == colorButton{
            vc = FishColorGameController(isStimulateGame: false)
        }else if sender == bubbleButton{
            vc = BubbleGameController(isStimulateGame: false)
        }else{
            vc = SwipeGameViewController(isStimulateGame: false)
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        NSLayoutConstraint.activate([
            //Main Background Constraint
            mainBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBg.topAnchor.constraint(equalTo: view.topAnchor),
            mainBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Fish color Constraint
            colorButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            colorButton.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 160),
//            colorButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            colorButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.42),
            
            //Swipe color Constraint
            bubbleButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -20),
            bubbleButton.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 160),
//            bubbleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            bubbleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.42),
            
            //Swipe color Constraint
            swipeButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            swipeButton.topAnchor.constraint(lessThanOrEqualTo: colorButton.bottomAnchor, constant: 25),
//            swipeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            swipeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.42),
            
            bottomLabel.topAnchor.constraint(equalTo: swipeButton.bottomAnchor, constant: 35),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

}
