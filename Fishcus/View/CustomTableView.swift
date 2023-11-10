//
//  CustomTableView.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 11/11/23.
//

import UIKit

class CustomTableView: UITableViewCell {

    var listDataFishing: ModelFishing?{
        didSet{
            guard let fishing = listDataFishing else {return}
            
            if let activity = fishing.activity{
                labelActivity.text = activity
            }
            
            if let time = fishing.time{
                
            }
            
            if let date = fishing.date{
                
            }
            
            if let fish = fishing.fish{
                
            }
            
            if let rare = fishing.rare{
                
            }
        }
    }
    
    private var labelActivity: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "primaryColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 11, weight: .regular)
        label.textColor = UIColor(named: "primaryColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var labelTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 11, weight: .regular)
        label.textColor = UIColor(named: "primaryColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func timeToString(time: TimeInterval) -> String{
        
        return ""
    }
   
}

