//
//  DelegateProtocol.swift
//  TadikaApp
//
//  Created by Vicky Irwanto on 20/10/23.
//

import UIKit

protocol DelegateProtocol: AnyObject{
    func changeShowInfo()
    func takePodomoroAlert()
    func continuePodomoroAlert()
    func dismissBreakExhausted()
}

protocol DelegateButtonStart: AnyObject{
    func changeScreen()
    func ShowAlertMinFocusDuration()
    func SendValueToggle()
    func SendDataFocus(_ activity: String, _ focusDuration: Int, _ breakDuration: Int)
}

protocol DelegatePickerTime: AnyObject{
    func sendFocusDuration(time: String)
}

protocol DelegateToggleSwitch: AnyObject{
    func ToggleSwitchRun()
}





