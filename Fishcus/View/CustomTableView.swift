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
                labelTime.text = convertMinuteStringToHourMinuteSecond(minuteString: time)
            }
            
            if let date = fishing.date{
                labelDate.text = date
            }
            
            
            if let rare = fishing.rare{
                switch fishing.fish{
                case "1":
                    imageFish.image = UIImage(named: "\(rare.lowercased())-sword-list")
                    break
                case "2":
                    imageFish.image = UIImage(named: "\(rare.lowercased())-clown-list")
                    break
                default:
                    imageFish.image = UIImage(named: "\(rare.lowercased())-beta-list")
                    break
                }
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
    
    private var imageFish: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var dateIcon: UIImageView = {
        let icon = UIImageView()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        icon.image = UIImage(systemName: "calendar", withConfiguration: symbolConfiguration)
        icon.tintColor = UIColor(named: "primaryColor")
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    private var timeIcon: UIImageView = {
        let icon = UIImageView()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 11, weight: .regular)
        icon.image = UIImage(systemName: "timer", withConfiguration: symbolConfiguration)
        icon.tintColor = UIColor(named: "primaryColor")
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.clear
        
        // Set the background color of all subviews to clear
        for subview in contentView.subviews {
            subview.backgroundColor = UIColor.clear
        }
        
        self.contentView.addSubview(labelActivity)
        self.contentView.addSubview(dateIcon)
        self.contentView.addSubview(timeIcon)
        self.contentView.addSubview(labelDate)
        self.contentView.addSubview(labelTime)
        self.contentView.addSubview(imageFish)
        
        NSLayoutConstraint.activate([
            labelActivity.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelActivity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            
            dateIcon.topAnchor.constraint(equalTo: labelActivity.bottomAnchor, constant: 5),
            dateIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            
            labelDate.topAnchor.constraint(equalTo: labelActivity.bottomAnchor, constant: 5),
            labelDate.leadingAnchor.constraint(equalTo: dateIcon.trailingAnchor, constant: 2),
            
            timeIcon.topAnchor.constraint(equalTo: labelActivity.bottomAnchor, constant: 5),
            timeIcon.leadingAnchor.constraint(equalTo: labelDate.trailingAnchor, constant: 30),
            
            labelTime.topAnchor.constraint(equalTo: labelActivity.bottomAnchor, constant: 5),
            labelTime.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 2),
            
            imageFish.widthAnchor.constraint(equalToConstant: 65),
            imageFish.heightAnchor.constraint(equalToConstant: 50),
            imageFish.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageFish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func convertMinuteStringToHourMinuteSecond(minuteString: String) -> String {
        guard let minutes = Int(minuteString) else {
            return "Invalid input"
        }
        
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        let seconds = remainingMinutes * 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, remainingMinutes, seconds)
        return timeString
    }
   
}

