//
//  ViewController.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 23/10/23.
//

import UIKit

protocol MyViewDelegate: AnyObject {
    func didTapButton()
}

class MyView: UIView {
    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Info", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: MyViewDelegate?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    private func setupView(){
        addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            myButton.widthAnchor.constraint(equalToConstant: 200),
            myButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        delegate?.didTapButton()
    }
    
    
}

class ViewController: UIViewController, MyViewDelegate {
    func didTapButton() {
        print(showInfo)
        showInfo.toggle()
        print(showInfo)
    }
    
    
    var showInfo = false
    let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myView)
        view.backgroundColor = .systemBackground
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant: 200),
            myView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        myView.delegate = self
        
    }


}

