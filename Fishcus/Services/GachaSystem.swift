//
//  GachaSystem.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 08/11/23.
//

import UIKit


class GachaSystem{
    
    private enum FishType {
        case common
        case rare
        case neptunian
    }
    
    private let commonFishProbabilities = [0.28, 0.28, 0.28]
    private let rareFishProbabilities = [0.033, 0.033, 0.033]
    private let neptunianFishProbabilities = [0.016, 0.016, 0.016]
    
    public var setFish: String = ""
    public var setRarerity: String = ""
    
    init() {
        var getFish: String = ""{
            didSet{
                self.setFish = getFish
            }
        }
        var getRarerity: String = ""{
            didSet{
                self.setRarerity = getRarerity
            }
        }
        self.gachaPull()
    }

    private func randomNumber(probabilities: [Double]) -> Int {
        let sum = probabilities.reduce(0, +)
        let rnd = Double.random(in: 0.0 ..< sum)
        var accum = 0.0
        for (i, p) in probabilities.enumerated() {
            accum += p
            if rnd < accum {
                return i
            }
        }
        return (probabilities.count - 1)
    }
   
    public func reset() {
        setFish = ""
        setRarerity = ""
    }
    
    func gachaPull(){
        let fishType = randomNumber(probabilities: [0.85, 0.10, 0.05])
        switch fishType {
        case 0:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "C"
//            return "Common fish \(specificFish + 1)"
        case 1:
            let specificFish = randomNumber(probabilities: rareFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "R"
//            print("Rare fish \(specificFish + 1)")
//            return "Rare fish \(specificFish + 1)"
        default:
            let specificFish = randomNumber(probabilities: neptunianFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "N"
//            print("Neptunian fish \(specificFish + 1)")
//            return "Neptunian fish \(specificFish + 1)"
        }
    }
    
    
}
