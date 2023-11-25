//
//  SetupFocusViewController.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 17/11/23.
//

import UIKit

class SetupFocusViewController: UIViewController, DelegateButtonStart {
    
    let smallScreen = UIScreen.main.bounds.size.height <= 667
    
    // setup focus var
    weak var delegateProtocol: DelegateSetupFocus?
    let myUserDefault = UserDefaults.standard
    var cycleBackground: Int = 0
    
    var myButtons = [UIButton]()
    var vc: UIViewController?
    var myToggle: Bool = false{
        didSet{
            if myToggle{
                vc = randomizeGameController()
            }else{
                vc = FocusViewController()
            }
        }
    }
    var changeScreenBool: Bool = false{
        didSet{
            MoveScreen(vc ?? FocusViewController())
        }
    }
    var selectedIndex : Int = 0 {
        didSet{
            cycleBackground = selectedIndex
            UpdateButtonImage()
            UpdateCycleBg(selectedIndex)
        }
    }
    var cycles: [String] = ["automatic-cycle","morning", "evening", "night"]
    
    private var cycleBg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "automatic-cycle")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    private var cycleIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "automatic-cycle")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var startFocusSetup : SetupFocusModeAlert = {
        let view = SetupFocusModeAlert()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var guidedTutorial = ReuseableInfoView(bgStyle: .type1, mascotIcon: .mascot3, labelText: "This is where you set up your focus session! For this tutorial, click ‘Start’ to begin your session.", position: false, labelTextStyle: .label3)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = UIColor.MyColors.primaryColor
        
        /// Create a custom view for the back button
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "btn-navigation-back"), for: .normal)
      
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.sizeToFit()

        let customBackButton = UIBarButtonItem(customView: backButton)

        // Assign the custom back button to the left bar button item
        navigationItem.leftBarButtonItem = customBackButton
        
        // SetupView
        SetupView()
        
        // Setup Layouts
        SetupLayouts()
       
        
        // Setup Delegate
        SetupDelegate()
        
        //Setup Guided Tutorial
        SetupGuidedTutorial()
        
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func SetupGuidedTutorial(){
        if((myUserDefault.data(forKey: "focusData"))?.isEmpty == nil){
            view.addSubview(guidedTutorial)
            
            NSLayoutConstraint.activate([
                guidedTutorial.topAnchor.constraint(equalTo: view.topAnchor),
                guidedTutorial.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                guidedTutorial.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                guidedTutorial.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(removeGuidedTutorial(_:)))
            guidedTutorial.addGestureRecognizer(gesture)
        }
    }
    
    @objc func removeGuidedTutorial(_ gesture: UITapGestureRecognizer){
        guard let currentView = gesture.view else{return}
        currentView.removeFromSuperview()
        
    }
    
    func SetupDelegate(){
        startFocusSetup.delegateChangeScreen = self
    }
    
    func SetupView(){
        view.addSubview(cycleBg)
        view.addSubview(horizontalStack)
        SetupCycleView()
        view.addSubview(startFocusSetup)
    }
    
    func SetupLayouts(){
        
        if smallScreen{
            NSLayoutConstraint.activate([
                cycleBg.topAnchor.constraint(equalTo: view.topAnchor),
                cycleBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                cycleBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                cycleBg.heightAnchor.constraint(equalToConstant: 200)
            ])
        }else{
            NSLayoutConstraint.activate([
                cycleBg.topAnchor.constraint(equalTo: view.topAnchor),
                cycleBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                cycleBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
          
        }
        
        NSLayoutConstraint.activate([

            horizontalStack.topAnchor.constraint(equalTo: cycleBg.bottomAnchor, constant: smallScreen ? view.bounds.height * 0.1  : view.bounds.height * 0.03),
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startFocusSetup.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 15),
            startFocusSetup.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startFocusSetup.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startFocusSetup.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func MoveScreen(_ vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func changeScreen() {
        changeScreenBool = true
    }
    
    func SendValueToggle() {
        myToggle.toggle()
    }
    
    func SendDataFocus(_ activity: String, _ focusDuration: Int, _ breakDuration: Int) {
        myUserDefault.set(activity, forKey: "activity")
        myUserDefault.set(focusDuration, forKey: "focusDuration")
        myUserDefault.set(breakDuration, forKey: "breakDuration")
        myUserDefault.set(self.cycleBackground, forKey: "cycle")
    }
    
    func ShowAlertMinFocusDuration(_ msg: String) {
        let alert = UIAlertController(title: "Warning", message: "\(msg)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func SetupCycleView(){
        
        myButtons.removeAll()
        
        for (index, _) in cycles.enumerated()  {
            
            let iconBtn: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleAspectFit
                image.tintColor = UIColor.MyColors.primaryColor
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            
            let cycleContainer: UIButton = {
                let view = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                view.contentMode = .center
                view.tag = index
                view.translatesAutoresizingMaskIntoConstraints = false
                
                return view
            }()
            
            horizontalStack.addArrangedSubview(cycleContainer)
            
            switch index {
            case 1:
                iconBtn.image = UIImage(systemName: "sun.max.fill")
                cycleContainer.addSubview(iconBtn)
                break
            case 2:
                iconBtn.image = smallScreen ? UIImage(named: "horizon.fill") : UIImage(systemName: "sun.horizon.fill")
                iconBtn.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
                cycleContainer.addSubview(iconBtn)
                break
            case 3:
                iconBtn.image = UIImage(systemName: "moon.fill")
                cycleContainer.addSubview(iconBtn)
                break
            default:
                iconBtn.image = UIImage(named: "icon-cycle-auto")
                cycleContainer.addSubview(iconBtn)
                break
            }
            
            NSLayoutConstraint.activate([
                iconBtn.centerXAnchor.constraint(equalTo: cycleContainer.centerXAnchor),
                iconBtn.centerYAnchor.constraint(equalTo: cycleContainer.centerYAnchor)
            ])
            
            
            cycleContainer.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
            
            myButtons.append(cycleContainer)
        }
        
        UpdateButtonImage()
    }

    @objc func btnAction(sender: UIButton){
        selectedIndex = sender.tag
    }
    
    func UpdateButtonImage(){
        for button in myButtons {
            let image = GetImageFromIndex(at: button.tag)
            button.setImage(image, for: .normal)
        }
    }
    
  
    func GetImageFromIndex(at index: Int) -> UIImage{
        
        if index == selectedIndex{
            return UIImage(named: "btn-ellipse-selected")!
        }else{
            return UIImage(named: "btn-ellipse")!
        }
    }
    
    func UpdateCycleBg(_ index: Int){
        switch index{
        case 1:
            cycleBg.image = UIImage(named: "morning")
            break
        case 2:
            cycleBg.image = UIImage(named: "evening")
            break
        case 3:
            cycleBg.image = UIImage(named: "night")
            break
        default:
            cycleBg.image = UIImage(named: "automatic-cycle")
            break
        }
    }
    
    func randomizeGameController() -> UIViewController {
        let randomIndex = Int(arc4random_uniform(2))
        
        if randomIndex == 0 {
            return FishColorGameController(isStimulateGame: true)
        } else if randomIndex == 1 {
            return SwipeGameViewController(isStimulateGame: true)
        } else {
            return BubbleGameController(isStimulateGame: true)
        }
    }

}
