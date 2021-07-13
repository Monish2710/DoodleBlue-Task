//
//  ViewController.swift
//  Sample Task
//
//  Created by User on 13/07/21.
//

import UIKit

class ViewController: UIViewController,CAPSPageMenuDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var availableCount: UILabel!
    @IBOutlet weak var loanedCount: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        pageMenuSetup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        loanedCount.text = "\(Singleton.sharedInstance.newDataArray.count)"
        availableCount.text = "\(Singleton.sharedInstance.dataArray.count)"
    }

    func pageMenuSetup()
    {
        
        let StoaryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller1 = StoaryBoard.instantiateViewController(withIdentifier: "MainViewController")as! MainViewController
        controller1.title = "LOANED ITEMS"
        controller1.isState = true
        controllerArray.append(controller1)
        
        let controller2 = StoaryBoard.instantiateViewController(withIdentifier: "MainViewController")as! MainViewController
        controller2.title = "AVAILABLE ITEMS"
        controller2.isState = false
        controllerArray.append(controller2)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.black),
            .menuMargin(10.0),
            .menuHeight(60.0),
            .selectedMenuItemLabelColor(UIColor(red: 28.0/255.0, green: 43.0/255.0, blue: 68.0/255.0, alpha: 1.0)),
            .menuItemWidth(mainView.frame.width/2),
            .useMenuLikeSegmentedControl(true),
            .selectionIndicatorHeight(3),
            .menuItemSeparatorPercentageHeight(0)
        ]
        let setframe =  self.mainView.bounds
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: setframe, pageMenuOptions: parameters)
        pageMenu?.controllerScrollView.isScrollEnabled = false
        pageMenu?.delegate = self as CAPSPageMenuDelegate
        self.addChild(pageMenu!)
        self.mainView.addSubview(pageMenu!.view)
}
}
