//
//  CountDownRingView.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit

class CountdownRingView: UIView {
    private var backgroundLayer: CAShapeLayer!
    private var ringLayer: CAShapeLayer!
//    private var startIconLayer: CALayer!
    
    // Properties to customize the ring
    var ringColor: UIColor = UIColor(named: "primaryColor")!
    var ringWidth: CGFloat = 10.0
    var backgroundWidth: CGFloat = 15.0
//    var startIcon: UIImage?
    
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
        // Create the background layer
        backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor(named: "regular-text")?.cgColor
        backgroundLayer.lineWidth = backgroundWidth
        layer.addSublayer(backgroundLayer)
        
        // Create the ring layer
        ringLayer = CAShapeLayer()
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = ringColor.cgColor
        ringLayer.lineWidth = ringWidth
        ringLayer.lineCap = .round
        layer.addSublayer(ringLayer)
        
        // Create the start icon layer
//        startIconLayer = CALayer()
//        startIconLayer.contentsGravity = .center
//        layer.addSublayer(startIconLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the layers' frames
        backgroundLayer.frame = bounds
        ringLayer.frame = bounds
        
        // Create a circular path for the background layer
        let backgroundPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.lineWidth = 45
        
        // Create a circular path for the ring layer
        let ringRadius = (min(bounds.width, bounds.height) - ringWidth) / 2
        let ringPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        ringLayer.path = ringPath.cgPath
        ringLayer.lineWidth = 35
        
        // Set the initial strokeEnd to 1.0 to show the full circle
        ringLayer.strokeEnd = 1.0
        
        
        // Set the start icon image
//        if let startIcon = startIcon {
//            startIconLayer.contents = startIcon.cgImage
//            startIconLayer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
//            startIconLayer.position = CGPoint(x: 100, y: 10)
//            let rotationAngle: CGFloat = CGFloat.pi / 1.5 // Adjust the rotation angle as needed
//            startIconLayer.transform = CATransform3DRotate(startIconLayer.transform, rotationAngle, 0, 0, -0.8)
//        }
        
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
        ringLayer.strokeStart = 1 - progress
        
        
        if remainingTime <= 0 {
            timer?.invalidate()
            // Countdown has completed, you can trigger an action here if needed
        }
    }

}


