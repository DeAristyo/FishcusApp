//
//  ResultListViewController.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 31/10/23.
//

import UIKit

class ResultListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
        var focusData: [[String: String]] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Create a new bar button item
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
                
                // Set the new bar button item as the left bar button item
                self.navigationItem.leftBarButtonItem = backButton
            
            view.backgroundColor = UIColor.white
            navigationItem.title = "Focus Result"
            // Initialize the table view
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            // Add the table view to the view hierarchy
            view.addSubview(tableView)
            
            // Load the data from UserDefaults
            loadData()
        }
        
        func loadData() {
            let myUserDefault = UserDefaults.standard
            if let data = myUserDefault.data(forKey: "focusData"),
               let decodedData = try? JSONDecoder().decode([[String: String]].self, from: data) {
                focusData = decodedData
            }
        }
        
        // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return focusData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let data = focusData[indexPath.row]
            cell.textLabel?.text = "\(data["date"] ?? "") - \(data["time"] ?? "") - \(data["activity"] ?? "")"// Display the activity as the cell text
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let data = focusData[indexPath.row]
            
            let resultScreenVC = ResultViewController(time: data["time"] ?? "", activity: data["activity"] ?? "")
            self.navigationController?.pushViewController(resultScreenVC, animated: true)
        }
    
    @objc func backButtonTapped() {
        // Instantiate the view controller you want to navigate to
        let newViewController = HomeViewController()
        // Push the new view controller onto the navigation stack
        self.navigationController?.setViewControllers([newViewController], animated: true)
    }
    

}
