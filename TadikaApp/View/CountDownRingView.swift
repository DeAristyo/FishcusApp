//
//  CountDownRingView.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit

class CountdownRingView: UIView {
    private var circleLayer: CAShapeLayer!
    
    // Properties to customize the ring
    var ringColor: UIColor = UIColor(red: 0.333, green: 0.502, blue: 0.647, alpha: 1)
    var ringWidth: CGFloat = 50.0
    
    // The duration for the countdown in seconds
    var countdownDuration: TimeInterval = 03.0
    
    private var startTime: Date?
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupRing()
    }
    
    private func setupRing() {
        // Create the circle layer
        circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = ringColor.cgColor
        circleLayer.lineWidth = ringWidth
        
        // Create a circular path
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - ringWidth) 
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        circleLayer.path = path.cgPath
        
        // Set the initial strokeEnd to 1.0 to show the full circle
        circleLayer.strokeEnd = 1.0
        
        layer.addSublayer(circleLayer)
    }
    
    func startCountdown() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateRing), userInfo: nil, repeats: true)
    }
    
    @objc private func updateRing() {
        guard let startTime = startTime else { return }
        let elapsed = Date().timeIntervalSince(startTime)
        let remainingTime = max(countdownDuration - elapsed, 0)
        let progress = CGFloat(remainingTime / countdownDuration)
        circleLayer.strokeEnd = progress
        
        if remainingTime <= 0 {
            timer?.invalidate()
            // Countdown has completed, you can trigger an action here if needed
        }
    }
}

