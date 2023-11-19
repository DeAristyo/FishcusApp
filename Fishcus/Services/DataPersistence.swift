//
//  DataPersistence.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 14/11/23.
//

import UIKit


class DataPersistence{
    let gachaSytem = GachaSystem()
    let myUserDefault = UserDefaults.standard
    let fishingData = GetDataFishing.getData().count
    var timerStart: Int
    var text: String
    var setFish: String
    var rarerity: String
    
    init(timerStart: Int, text: String, setFish: String, rarerity: String) {
        self.timerStart = timerStart
        self.text = text
        self.setFish = setFish
        self.rarerity = rarerity
    }
    
    private func ProcessingData(){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        let dateString = dateFormatter.string(from: currentDate)
        
        let newData: [String: String] = [
            "id": fishingData < 1 ? "1" : "\(fishingData+1)",
            "date": dateString,
            "time": "\(timerStart)",
            "activity": text,
            "fish": self.setFish,
            "rarerity": self.rarerity
        ]
        
        var existingData: [[String: String]]
        
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            existingData = decodedData
        } else {
            existingData = []
        }
        
        existingData.append(newData)
        
        if let encodedData = try? JSONEncoder().encode(existingData) {
            myUserDefault.set(encodedData, forKey: "focusData")
        }
        
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            for dictionary in decodedData {
                for (key, value) in dictionary {
                    print("Key: \(key), Value: \(value)")
                }
            }
        } else {
            print("No data found in UserDefaults for the key 'focusData'")
        }
    }
    
    func saveContent(){
        self.ProcessingData()
    }
   
}
