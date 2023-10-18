//
//  CoreHapticViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 18/10/23.
//

import UIKit
import CoreHaptics

class CoreHapticViewController: UIViewController {

    var i = 0
    var engine: CHHapticEngine?

        override func viewDidLoad() {
            super.viewDidLoad()

            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(btn)

            btn.widthAnchor.constraint(equalToConstant: 128).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 128).isActive = true
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            btn.setTitle("Tap here!", for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.addTarget(self, action: #selector(tapped), for: .touchUpInside)
            
            prepareHaptic()
        }

        @objc func tapped() {
           complexSuccess()
        }
    
    func prepareHaptic(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch{
            print("Ngk ada haptic hp mu blok : \(error.localizedDescription)")
        }
    }
    
    func complexSuccess(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 100)
        let sharpness =  CHHapticEventParameter(parameterID: .hapticSharpness, value: 100)
        let event =  CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        events.append(event)
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("fail \(error.localizedDescription)")
        }
    }

}
