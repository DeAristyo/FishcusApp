//
//  ViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 23/10/23.
//

import UIKit

protocol TimerViewDelegate: AnyObject {
    func didPressInfoButton()
}

class TimerView: UIView {
    
    weak var delegate: TimerViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Info", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var timer: Timer?
    private var countdown: Int = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(timerLabel)
        addSubview(infoButton)
        
        titleLabel.text = "Title"
        timerLabel.text = "\(countdown)"
        
        infoButton.addTarget(self, action: #selector(didPressInfoButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120),
            
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            infoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            infoButton.widthAnchor.constraint(equalToConstant: 200),
            infoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        startTimer()
        
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        countdown -= 1
        timerLabel.text = "\(countdown)"
        
        if countdown <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func didPressInfoButton() {
        delegate?.didPressInfoButton()
    }
}


class ViewController: UIViewController, TimerViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timerView = TimerView()
        timerView.delegate = self
        timerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerView)
        
        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: view.topAnchor),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didPressInfoButton() {
        // Show other information here
        print("Info button pressed")
    }
    
    
}
