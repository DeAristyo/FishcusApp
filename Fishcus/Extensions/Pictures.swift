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
        static var bubblesGame: UIImage = {return UIImage(named: "BubbleGame")!}()
        static var colorGame: UIImage = {return UIImage(named: "ColorGame")!}()
        static var swipeGame: UIImage = {return UIImage(named: "SwipeGame")!}()
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
        static var day: UIImage = {return UIImage(named: "HomeStatic_Day")!}()
        static var evening: UIImage = {return UIImage(named: "HomeStatic_Evening")!}()
        static var night: UIImage = {return UIImage(named: "HomeStatic_Night")!}()
    }
    
    struct viewBackgrounds{
        static var gameScreenBg: UIImage = {return UIImage(named: "GameScreenBackground")!}()
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
    
    struct tabs{
        static var target: UIImage = {return UIImage(named: "target")!}()
        static var targetActive: UIImage = {return UIImage(named: "targetActive")!}()
        static var gameActive: UIImage = {return UIImage(named: "gameActive")!}()
        static var game: UIImage = {return UIImage(named: "game")!}()
        static var clockActive: UIImage = {return UIImage(named: "clockActive")!}()
        static var clock: UIImage = {return UIImage(named: "clock")!}()
    }
    
    //Tab bar selection indicator
    static func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: 0,
                                                    width: size.width,
                                                    height: size.height),
                                cornerRadius: size.height / 2)
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
