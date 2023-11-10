//
//  Bubble.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 08/11/23.
//

import UIKit

class BubbleView: UIImageView {    var number: Int
    let bubbleSize = 55
    var xPosition = 0
    var yPosition = 0
    
    init(number: Int) {
        self.number = number
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        // Load the bubble image based on the number
        let imageName = "Bubble\(number)"
        image = UIImage(named: imageName)
        
        // Calculate the size of the UIImageView based on a percentage of the screen width
        let screenWidth = UIScreen.main.bounds.width
        let bubbleSizePercentage: CGFloat = 0.2
        
        let calculatedBubbleSize = screenWidth * bubbleSizePercentage
        bounds = CGRect(x: 0, y: 0, width: calculatedBubbleSize, height: calculatedBubbleSize)
        
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
