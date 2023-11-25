//
//  TabBarController.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 18/11/23.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var selectionIndicatorImageView: UIImageView?
    private let indicatorHeight: CGFloat = 52
    private let indicatorWidth: CGFloat = 73
    private let isiPhoneSE = UIScreen.main.bounds.height <= 667
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
        createSelectionIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isiPhoneSE{
            let tabBarFrame = tabBar.frame
            let newTabBarFrame = CGRect(x: tabBarFrame.origin.x, y: tabBarFrame.origin.y - 40, width: tabBarFrame.width, height: tabBarFrame.height + 40)
            tabBar.frame = newTabBarFrame
        }
        updateSelectionIndicatorPosition()
    }
    
    private func setupViewControllers() {
        let focusViewController = UINavigationController(rootViewController: DynamicHomeViewController())
        focusViewController.tabBarItem = UITabBarItem(title: "Focus", image: UIImage.tabs.target, selectedImage: UIImage.tabs.targetActive)
        
        let historyViewController = UINavigationController(rootViewController: ResultListViewController())
        historyViewController.tabBarItem = UITabBarItem(title: "History", image: UIImage.tabs.clock, selectedImage: UIImage.tabs.clockActive)
        
        let trainingViewController = UINavigationController(rootViewController: GameViewController())
        trainingViewController.tabBarItem = UITabBarItem(title: "Training", image: UIImage.tabs.game, selectedImage: UIImage.tabs.gameActive)
        
        // Set image insets for tab bar items
        let yOffset: CGFloat = isiPhoneSE ? 20.0 : 0.0 // Adjust this value as needed
        
        focusViewController.tabBarItem.imageInsets = UIEdgeInsets(top: -yOffset, left: 0, bottom: yOffset, right: 0)
        historyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: -yOffset, left: 0, bottom: yOffset, right: 0)
        trainingViewController.tabBarItem.imageInsets = UIEdgeInsets(top: -yOffset, left: 0, bottom: yOffset, right: 0)
        
        self.viewControllers = [focusViewController, historyViewController, trainingViewController]
    }
    
    private func setupTabBarAppearance() {
        // Set the unselected and selected colors for the tab bar items
        let unselectedColor = UIColor.MyColors.regularText
        let selectedColor = UIColor.MyColors.primaryColor
        
        // Set the tab bar's background color to clear to remove any default color
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        // Calculate the safe area insets at the bottom to extend the layer if needed
        let bottomPadding: CGFloat = view.window?.safeAreaInsets.bottom ?? 0
        
        // Define the minimum height and side padding for the custom tab bar layer
        let minimumHeight: CGFloat = 70
        let sidePadding: CGFloat = 16
        
        // Create a rounded rect layer that will serve as a background for the tab bar
        let layerHeight = max(minimumHeight, tabBar.bounds.height + bottomPadding)
        let layer = CAShapeLayer()
        var yPosition = tabBar.bounds.minY - (layerHeight - tabBar.bounds.height) / 2
        
        if isiPhoneSE {
            yPosition -= 40 // Add 40 points for iPhone SE
        }
        
        let layerPath = UIBezierPath(roundedRect: CGRect(x: sidePadding,
                                                         y: isiPhoneSE ? -10 : yPosition,
                                                         width: tabBar.bounds.width - (sidePadding * 2),
                                                         height: layerHeight),
                                     cornerRadius: layerHeight / 2).cgPath
        layer.path = layerPath
        layer.fillColor = UIColor.MyColors.primaryColor.cgColor
        layer.opacity = 0.8
        layer.zPosition = -2
        tabBar.layer.insertSublayer(layer, at: 0)
        
        let yOffset: CGFloat = isiPhoneSE ? 40.0 : 0.0 // You may need to adjust this value
        
        // Adjust the item insets to center the icons vertically
        let tabBarItemInset: CGFloat = bottomPadding > 0 ? (layerHeight - tabBar.bounds.height) / 6 : 0
        
        UITabBarItem.appearance().titlePositionAdjustment = isiPhoneSE ? UIOffset(horizontal: 0, vertical: -yOffset) : UIOffset(horizontal: 0, vertical: -tabBarItemInset)
        //        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -tabBarItemInset)
        
        // Set unselected and selected item colors
        UITabBar.appearance().unselectedItemTintColor = unselectedColor
        UITabBar.appearance().tintColor = selectedColor
        
        if let numberOfItems = tabBar.items?.count, numberOfItems > 0 {
            _ = CGSize(width: tabBar.frame.width / CGFloat(numberOfItems), height: tabBar.frame.height)
            createSelectionIndicator()
        }
    }
    
    private func createSelectionIndicator() {
        if selectionIndicatorImageView == nil {
            let selectionIndicatorImage = UIImage.createSelectionIndicator(color: UIColor.MyColors.regularText, size: CGSize(width: indicatorWidth, height: indicatorHeight), lineWidth: 2.0)
            selectionIndicatorImageView = UIImageView(image: selectionIndicatorImage)
            selectionIndicatorImageView?.layer.cornerRadius = indicatorHeight / 2
            selectionIndicatorImageView?.layer.masksToBounds = true
            selectionIndicatorImageView?.layer.zPosition = -1
            selectionIndicatorImageView?.tag = 999
            if let indicator = selectionIndicatorImageView {
                tabBar.addSubview(indicator)
            }
            updateSelectionIndicatorPosition()
        }
    }
    
    private func updateSelectionIndicatorPosition() {
        let count = tabBar.items?.count ?? 0
        let tabBarItemWidth = tabBar.bounds.width / CGFloat(count)
        let xPosition = tabBarItemWidth * CGFloat(selectedIndex) + (tabBarItemWidth - indicatorWidth) / 2
        
        // Calculate the yPosition to float 40 points above the bottom of the screen
        let screenHeight = UIScreen.main.bounds.height
        var yPosition = tabBar.bounds.height - indicatorHeight - (view.safeAreaInsets.bottom - 2)
        
        if isiPhoneSE {
            yPosition -= 40 // Add 40 points for iPhone SE
        }
        
        if let indicator = selectionIndicatorImageView {
            let animationDuration = indicator.frame == .zero ? 0 : 0.25
            UIView.animate(withDuration: animationDuration) {
                indicator.frame = CGRect(x: xPosition, y: yPosition, width: self.indicatorWidth, height: self.indicatorHeight)
                self.tabBar.bringSubviewToFront(indicator) // Bring the indicator to the front
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item), index != selectedIndex {
            DispatchQueue.main.async {
                self.updateSelectionIndicatorPosition()
            }
        }
    }
}
