//
//  Pictures.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 17/11/23.
//

import UIKit

extension UIImage{
    struct tutorial{
        static var bubbleGameTutorial: UIImage = {return UIImage(named: "bubbleGameTutorial")!}()
        static var dragGameTutorial: UIImage = {return UIImage(named: "dragGameTutorial")!}()
        static var fishGameTutorial: UIImage = {return UIImage(named: "fishGameTutorial")!}()
        static var swipeGameTutorial: UIImage = {return UIImage(named: "swipeGameTutorial")!}()
    }
    
    struct button{
        static var btnEmpty: UIImage = {return UIImage(named: "btn-empty")!}()
        static var btnBack: UIImage = {return UIImage(named: "btn-back")!}()
        static var btnBackMain: UIImage = {return UIImage(named: "btn-backmain")!}()
        static var btnContinue: UIImage = {return UIImage(named: "btn-continue")!}()
        static var btnDone: UIImage = {return UIImage(named: "btn-done")!}()
        static var btnFinish: UIImage = {return UIImage(named: "btn-finish")!}()
        static var btnHistory: UIImage = {return UIImage(named: "btn-history")!}()
        static var btnShare: UIImage = {return UIImage(named: "btn-share")!}()
        static var btnTake: UIImage = {return UIImage(named: "btn-take")!}()
    }
    
    struct frames{
        static var frameLeftGreen: UIImage = {return UIImage(named: "frameLeftGreen")!}()
        static var frameLeftBlue: UIImage = {return UIImage(named: "frameLeftBlue")!}()
        static var frameLeftRed: UIImage = {return UIImage(named: "frameLeftRed")!}()
        static var frameRightBlue: UIImage = {return UIImage(named: "frameRightBlue")!}()
        static var frameRightGreen: UIImage = {return UIImage(named: "frameRightGreen")!}()
        static var frameRightRed: UIImage = {return UIImage(named: "frameRightRed")!}()
    }
    
    struct fishes{
        static var BlueFish: UIImage = {return UIImage(named: "BlueFish")!}()
        static var GreenFish: UIImage = {return UIImage(named: "GreenFish")!}()
        static var RedFish: UIImage = {return UIImage(named: "RedFish")!}()
    }
    
    struct staticHomeBg{
        static var day: UIImage = {return UIImage(named: "HomeScreen.001")!}()
        static var evening: UIImage = {return UIImage(named: "HomeScreen.002")!}()
        static var night: UIImage = {return UIImage(named: "HomeScreen.003")!}()
    }
    
    struct dynamicButton{
        static var day: UIImage = {return UIImage(named: "DayButton")!}()
        static var evening: UIImage = {return UIImage(named: "EveningButton")!}()
        static var night: UIImage = {return UIImage(named: "NightButton")!}()
        static var dayActive: UIImage = {return UIImage(named: "DayButtonActive")!}()
        static var eveningActive: UIImage = {return UIImage(named: "EveningButtonActive")!}()
        static var nightActive: UIImage = {return UIImage(named: "NightButtonActive")!}()
    }
    
    struct focusButton{
        static var eclipse: UIImage = {return UIImage(named: "EclipseButtonFocus")!}()
        static var focusButton: UIImage = {return UIImage(named: "ButtonFocus")!}()
    }
    
    struct icons{
        static var quotesIcon: UIImage = {return UIImage(named: "quotesIcon")!}()
    }
}
