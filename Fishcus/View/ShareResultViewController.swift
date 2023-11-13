//
//  ShareResultViewController.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 08/11/23.
//

import UIKit

class ShareResultViewController: UIViewController {
    
    var time: String?
    var activity: String?
    var fish: String?
    var rare: String?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "result-color")
        self.navigationItem.hidesBackButton = true
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientContainer.bounds
        gradientContainer.layer.insertSublayer(gradient, at: 0)
        
        self.labelRarerity.alpha =  1.0
        self.rectangleRarerity.alpha =  1.0
        
        
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
        default:
            gradient.colors = [UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0).cgColor,
                               UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1).cgColor]
            self.gradientBackground.backgroundColor = UIColor(red: 0.286, green: 0.361, blue: 0.29, alpha: 1)
            self.labelBig.text = "Nothing :("
            self.fishImage.image = UIImage(named: "nothing-img")
            self.rectangleRarerity.layer.borderColor = UIColor.clear.cgColor
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
            labelSmall.topAnchor.constraint(equalTo: fishImage.bottomAnchor, constant: self.rare == "C" ? 200 : 150),
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
        
      
    }
    
  

}
