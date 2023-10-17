//
//  ViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 12/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let helloWorld = UILabel()
        
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.systemFont(ofSize: 20)
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(helloWorld)
        
        NSLayoutConstraint.activate([
            helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }


}

