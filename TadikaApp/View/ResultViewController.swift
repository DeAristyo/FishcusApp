//
//  ResultViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 26/10/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var loadingView: UIView?
    
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
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let fishImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "fish-icon")
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var resultBtn: UIButton = {
        let image = UIButton(type: .custom)
        image.setImage(UIImage(named: "btn-continue"), for: .normal)
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var shareContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        view.backgroundColor = UIColor(named: "primaryColor")
        view.layer.zPosition = 13
        view.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = view.frame.size.width/2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var shareIcon: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "icon-share"), for: .normal)
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        view.text = "For \(myUserDefault.string(forKey: "time") ?? "") minutes of Study \(myUserDefault.string(forKey: "activity") ?? ""), I caught"
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
        view.text = "Koi, the Samurai!"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "primaryColor")
        self.navigationItem.hidesBackButton = true
        
        view.addSubview(myBgImage)
        
        NSLayoutConstraint.activate([
            myBgImage.topAnchor.constraint(equalTo: view.topAnchor),
            myBgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myBgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(fishImage)
        
        NSLayoutConstraint.activate([
            fishImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fishImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70)
        ])
        
        view.addSubview(labelSmall)
        
        NSLayoutConstraint.activate([
            labelSmall.topAnchor.constraint(equalTo: fishImage.bottomAnchor, constant: 33),
            labelSmall.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(labelBig)
        
        NSLayoutConstraint.activate([
            labelBig.topAnchor.constraint(equalTo: labelSmall.bottomAnchor, constant: 10),
            labelBig.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(resultBtn)
        
        NSLayoutConstraint.activate([
            resultBtn.topAnchor.constraint(equalTo: labelBig.bottomAnchor, constant: 48),
            resultBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35)
        ])
        
        view.addSubview(shareContainer)
        
        NSLayoutConstraint.activate([
            shareContainer.topAnchor.constraint(equalTo: labelBig.bottomAnchor, constant: 48),
            shareContainer.leadingAnchor.constraint(equalTo: resultBtn.trailingAnchor, constant: 23),
            shareContainer.widthAnchor.constraint(equalToConstant: 36),
            shareContainer.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        shareContainer.addSubview(shareIcon)
        
        NSLayoutConstraint.activate([
            shareIcon.centerXAnchor.constraint(equalTo: shareContainer.centerXAnchor),
            shareIcon.centerYAnchor.constraint(equalTo: shareContainer.centerYAnchor, constant: -2),
            shareIcon.widthAnchor.constraint(equalToConstant: 16),
            shareIcon.heightAnchor.constraint(equalToConstant: 21)
        ])
       
        shareIcon.addTarget(self, action: #selector(shareResult), for: .touchUpInside)
        resultBtn.addTarget(self, action: #selector(finish), for: .touchUpInside)
    }
    
    @objc func finish(){
        let newRootVc = HomeViewController()
        let navigationController = UINavigationController(rootViewController: newRootVc)
        
        self.navigationController?.setViewControllers([newRootVc], animated: true)
    }
    
    func captureScreen() -> UIImage? {
        let window = UIApplication.shared.keyWindow
        UIGraphicsBeginImageContextWithOptions(window!.frame.size, window!.isOpaque, 0.0)
        window!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @objc func shareResult(theButton: [UIButton]){
        if let image = captureScreen() {
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
