//
//  CountdownBarView.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 09/11/23.
//

import UIKit

class ProgressBarView: UIView {
    private var backgroundLayer: CAShapeLayer!
    private var barLayer: CAShapeLayer!
    private var startIconLayer: CALayer!
    
    var barColor: UIColor = UIColor(named: "primaryColor")!
    var barHeight: CGFloat = 20.0
    var startIcon = UIImage(named:"greenIconFIsh")
    
    var countdownDuration: TimeInterval = 05.0
    private var currentWidth: CGFloat = 50  // Initial width
    
    private var startTime: Date?
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBar()
    }
    
    private func setupBar() {
        backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = UIColor(named: "regular-text")?.cgColor
        backgroundLayer.lineWidth = 0
        layer.addSublayer(backgroundLayer)
        
        barLayer = CAShapeLayer()
        barLayer.fillColor = barColor.cgColor
        barLayer.lineWidth = barHeight
        barLayer.strokeStart = 1.0
        layer.addSublayer(barLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundLayer.frame = bounds
        barLayer.frame = bounds
        
        let cornerRadius = barHeight / 2
        let backgroundPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.lineWidth = 0
        
        let padding: CGFloat = 5.0
        let barY = (bounds.height - barHeight) / 2
        let barPath = UIBezierPath(roundedRect: CGRect(x: padding, y: barY, width: 50, height: barHeight), cornerRadius: cornerRadius)
        barLayer.path = barPath.cgPath
        
        let iconY = (bounds.height - 100) / 2
        
        if startIconLayer == nil, let startIcon = startIcon {
            startIconLayer = CALayer()
            startIconLayer?.contents = startIcon.cgImage
            startIconLayer?.contentsGravity = .resizeAspect
            startIconLayer?.zPosition = 100
            startIconLayer?.frame = CGRect(x: 0, y: iconY, width: 70, height: 100)
            layer.addSublayer(startIconLayer!)
        } else {
            // Update the existing startIconLayer's position
            startIconLayer?.frame = CGRect(x: 0, y: iconY, width: 70, height: 100)
        }
    }
    
    //    func startCountdown() {
    //        startTime = Date()
    //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBar), userInfo: nil, repeats: true)
    //    }
    
    func updateBar() {
        let padding: CGFloat = 5.0
        let finalWidth = bounds.width - 2 * padding
        let targetWidth = finalWidth / 5  // Calculate targetWidth
        
        currentWidth += targetWidth  // Increment the width
        currentWidth = min(currentWidth, finalWidth)  // Ensure it does not exceed finalWidth
        
        animateBarWidth(currentWidth)
        
        if let startIconLayer = startIconLayer {
            let iconX = padding + currentWidth - barHeight / 2
            let newPosition = CGPoint(x: iconX, y: bounds.midY)
            
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.fromValue = NSValue(cgPoint: startIconLayer.position)
            positionAnimation.toValue = NSValue(cgPoint: newPosition)
            positionAnimation.duration = 0.5  // Use the same duration as the barLayer animation
            positionAnimation.fillMode = .forwards
            positionAnimation.isRemovedOnCompletion = false
            
            startIconLayer.position = newPosition
            startIconLayer.add(positionAnimation, forKey: "iconPositionAnimation")
        }
    }
    
    private func animateBarWidth(_ newWidth: CGFloat) {
        let animation = CABasicAnimation(keyPath: "path")
        let cornerRadius = barHeight / 2
        let padding: CGFloat = 5.0
        let path = UIBezierPath(roundedRect: CGRect(x: padding, y: (bounds.height - barHeight) / 2, width: newWidth, height: barHeight), cornerRadius: cornerRadius)
        
        animation.fromValue = barLayer.path
        animation.toValue = path.cgPath
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        barLayer.path = path.cgPath
        barLayer.add(animation, forKey: "barWidthAnimation")
    }
}
