//
//  MotionServices.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 14/11/23.
//

import UIKit
import CoreMotion

class CoreMotionService{
   
    let motionThreshold: Double = 2.5 // Adjust the threshold as needed
    
    func isShaking(_ motionData: CMDeviceMotion) -> Bool {
        let acceleration = motionData.userAcceleration
        let totalAcceleration = sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
        return totalAcceleration >= motionThreshold
    }
}


