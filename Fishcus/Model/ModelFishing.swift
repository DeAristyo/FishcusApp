//
//  ModelFishing.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 11/11/23.
//

import UIKit


struct ModelFishing{
    let id: Int
    let activity: String?
    let date: String?
    let time: String?
    let fish: String?
    let rare: String?
}

class GetDataFishing{
   
    static func getData() -> [ModelFishing]{
        let myUserDefault = UserDefaults.standard
        var myData: [ModelFishing] = []
        var focusData: [[String:String]] = []
        if let data = myUserDefault.data(forKey: "focusData"),
           let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
            focusData = decodedData
        }
        
        for fishing in focusData{ 
                myData += [
                    ModelFishing(id: Int(fishing["id"] ?? "1") ?? 1,activity: (fishing["activity"] ?? ""), date: (fishing["date"] ?? ""), time: (fishing["time"] ?? ""), fish: (fishing["fish"] ?? ""), rare: (fishing["rarerity"] ?? ""))
                ]
        
        }
        
        return myData
    }
}
