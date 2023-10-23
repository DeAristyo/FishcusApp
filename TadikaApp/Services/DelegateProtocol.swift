//
//  DelegateProtocol.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 20/10/23.
//

import UIKit

protocol DelegateProtocol: AnyObject{
    func changeShowInfo(sender: TimerPause)
}

protocol CustomViewDelegate: AnyObject {
    func navigateToNextScreen()
}




