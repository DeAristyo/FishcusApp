//
//  ViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 23/10/23.
//

import UIKit



class ViewController: UIViewController {
    
    let gacha = GachaSystem()
    let getData = GetDataFishing.getData()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let button = UIButton(type: .system)
        button.setTitle("Pull", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(gachaPull), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
  
        
    }
    
    @objc func gachaPull(){
        gacha.gachaPullGroup4()
        print(gacha.setFish)
        print(gacha.setRarerity)
        gacha.reset()
    }
    
    
    
}
