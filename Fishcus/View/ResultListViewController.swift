//
//  ResultListViewController.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 31/10/23.
//

import UIKit

class ResultListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var fishingData = GetDataFishing.getData().sorted{$0.id > $1.id}
    
    private var infoScreen =  ReuseableInfoView(bgStyle: .type2, mascotIcon: .mascot1, labelText: "\"Take a look at your Focus History here and see how far you've come.\"", position: false, labelTextStyle: .label14)

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Create a custom view for the back button
        let backButton = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        backButton.setImage(UIImage(systemName: "chevron.backward")?.withConfiguration(symbolConfiguration), for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.rounded(ofSize: 15, weight: .bold)
        backButton.tintColor = UIColor(named: "primaryColor") ?? UIColor.white

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.sizeToFit()

        let customBackButton = UIBarButtonItem(customView: backButton)

        // Assign the custom back button to the left bar button item
        navigationItem.leftBarButtonItem = customBackButton

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.rounded(ofSize: 28, weight: .heavy), // Replace with your desired font and size
        ]
        
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = "Focus Result"
    
        // Initialize the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self


        let listBg = UIImageView()
        listBg.image = UIImage(named: "bg-list")
        listBg.contentMode = .scaleAspectFill
        listBg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listBg)

        NSLayoutConstraint.activate([
            listBg.topAnchor.constraint(equalTo: view.topAnchor),
            listBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listBg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(CustomTableView.self, forCellReuseIdentifier: "cell")
        
        if self.fishingData.count <= 1{
            let initialShowInfo = self.infoScreen
            initialShowInfo.layer.zPosition = 5
            
            self.view.addSubview(initialShowInfo)
            
            NSLayoutConstraint.activate([
                initialShowInfo.topAnchor.constraint(equalTo: self.view.topAnchor),
                initialShowInfo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                initialShowInfo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                initialShowInfo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
            let guideInfoGestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.guideTapGesture))
            initialShowInfo.isUserInteractionEnabled = true
            initialShowInfo.addGestureRecognizer(guideInfoGestureRecog)
        }

        // sort Descending data list
       print(fishingData)
    }
    
    func minuteToString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        
        return String(format: "%02i", minute)
    }
    
    @objc func guideTapGesture(gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else {return}
        currentView.removeFromSuperview()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fishingData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableView
        cell.listDataFishing = fishingData[indexPath.row]

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let data = fishingData[indexPath.row]

        let resultScreenVC = ResultViewController(time: (minuteToString(time: TimeInterval(data.time ?? "") ?? 0.0)), activity: (data.activity ?? ""), fish: (data.fish ?? ""), rare: (data.rare ?? ""))
        self.navigationController?.pushViewController(resultScreenVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear // Set the background color of the cell to yellow
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

