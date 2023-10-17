//
//  HomeViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 16/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    private var titleHi : UILabel = {
        let title  = UILabel()
        
        title.text = "Hi, "
        title.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var titleName : UILabel = {
        let title  = UILabel()
        
        title.text = "Player!"
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var titleInfo : UILabel = {
        let title  = UILabel()
        
        title.text = "Ready to fish more?  "
        title.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "bg")
        bgImage.contentMode = .scaleAspectFill
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        
        return bgImage
    }()
    
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var circleShape: UIView = {
        let circle = UIView()
        circle.frame = CGRect(x: 0, y: 0, width: 58, height: 58)
        circle.layer.backgroundColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1).cgColor
        circle.layer.cornerRadius = 29
        circle.clipsToBounds = true
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        
        return circle
    }()
    
    private var rankTitle: UILabel = {
        var view = UILabel()
        
        view.textColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        // Line height: 22 pt
        // (identical to box height)
        view.attributedText = NSMutableAttributedString(string: "FisherNovice", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    private var progressRank : UIProgressView = {
        let progress =  UIProgressView()
        progress.progress = 0.4
        progress.layer.cornerRadius = 10
        progress.layer.sublayers![1].backgroundColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1).cgColor
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 10
        progress.subviews[1].clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        return progress
    }()
    
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
    
    private var bgCircle : UIView = {
       let circle = UIView()
        circle.clipsToBounds = true
        circle.layer.backgroundColor =  UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 0.5).cgColor
        circle.layer.cornerRadius = 81
        circle.translatesAutoresizingMaskIntoConstraints =  false
        
        return circle
        
    }()
    
    private var innerCircle : UIView = {
       let circle = UIView()
        circle.clipsToBounds = true
        circle.layer.backgroundColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 0.7).cgColor
        circle.layer.cornerRadius = 64
        circle.translatesAutoresizingMaskIntoConstraints =  false
        
        return circle
        
    }()
    
    private var btnFocus: UIButton = {
       
        let btn =  UIButton()
        btn.setTitle("Focus", for: .normal)
        btn.layer.backgroundColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1).cgColor
        btn.layer.cornerRadius = 45
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
        
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        stackView.addArrangedSubview(titleHi)
        stackView.addArrangedSubview(titleName)
        
        view.addSubview(titleInfo)
        
        NSLayoutConstraint.activate([
            titleInfo.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            titleInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39)
        ])
        
        view.addSubview(circleShape)
        
        NSLayoutConstraint.activate([
            circleShape.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 15),
            circleShape.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            circleShape.widthAnchor.constraint(equalToConstant: 58),
            circleShape.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        
        let myTitle =  UILabel()
        myTitle.text = "You are a "
        myTitle.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        myTitle.textColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1)
        myTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myTitle)
        
        NSLayoutConstraint.activate([
            myTitle.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 18),
            myTitle.leadingAnchor.constraint(equalTo: circleShape.trailingAnchor, constant: 18)
        ])
        
        view.addSubview(rankTitle)
        
        NSLayoutConstraint.activate([
            rankTitle.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 18),
            rankTitle.leadingAnchor.constraint(equalTo: myTitle.trailingAnchor, constant: 0)
        ])
        
        view.addSubview(progressRank)
        
        NSLayoutConstraint.activate([
            progressRank.topAnchor.constraint(equalTo: myTitle.bottomAnchor, constant: 9),
            progressRank.leadingAnchor.constraint(equalTo: circleShape.trailingAnchor, constant: 18),
            progressRank.widthAnchor.constraint(equalToConstant: 203),
            progressRank.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        view.addSubview(fishing)
        
        NSLayoutConstraint.activate([
            fishing.topAnchor.constraint(equalTo: progressRank.bottomAnchor, constant: 85),
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
        
        
        btnFocus.addTarget(self, action: #selector(focusStart), for: .touchUpInside)
        
        
        
    }
    
    @objc func focusStart(){
        let vc = FocusViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
