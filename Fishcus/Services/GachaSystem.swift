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
    
    private var commonFishProbabilities: [Double] = []
    private var rareFishProbabilities: [Double] = []
    private var neptunianFishProbabilities: [Double] = []
    
    
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
    
    func gachaPullGroup1(){
        commonFishProbabilities = [0.22, 0.22, 0.22]
        rareFishProbabilities = [0.113, 0.113, 0.113]
        let fishType = randomNumber(probabilities: [0.66, 0.34])
        switch fishType {
        case 0:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "C"
            break

        default:
            let specificFish = randomNumber(probabilities: rareFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "R"
            break
        }
    }
    
    func gachaPullGroup2(){
        commonFishProbabilities = [0.20, 0.20, 0.20]
        rareFishProbabilities = [0.09, 0.09, 0.09]
        neptunianFishProbabilities = [0.043, 0.043, 0.043]
        let fishType = randomNumber(probabilities: [0.60, 0.27, 0.13])
        switch fishType {
        case 0:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "C"
            break
        case 1:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "R"
            break
        default:
            let specificFish = randomNumber(probabilities: neptunianFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "N"
            break
        }
    }
    
    func gachaPullGroup3(){
        commonFishProbabilities = [0.1867, 0.1867, 0.1867]
        rareFishProbabilities = [0.0967, 0.0967, 0.0967]
        neptunianFishProbabilities = [0.05, 0.05, 0.05]
        let fishType = randomNumber(probabilities: [0.56, 0.29, 0.15])
        switch fishType {
        case 0:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "C"
            break
        case 1:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "R"
            break
        default:
            let specificFish = randomNumber(probabilities: neptunianFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "N"
            break
        }
    }
    
    func gachaPullGroup4(){
        commonFishProbabilities = [0.173, 0.173, 0.173]
        rareFishProbabilities = [0.103, 0.103, 0.103]
        neptunianFishProbabilities = [0.0567, 0.0567, 0.0567]
        let fishType = randomNumber(probabilities: [0.52, 0.31, 0.17])
        switch fishType {
        case 0:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "C"
            break
        case 1:
            let specificFish = randomNumber(probabilities: commonFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "R"
            break
        default:
            let specificFish = randomNumber(probabilities: neptunianFishProbabilities)
            self.setFish = "\(specificFish+1)"
            self.setRarerity = "N"
            break
        }
    }
    
}
