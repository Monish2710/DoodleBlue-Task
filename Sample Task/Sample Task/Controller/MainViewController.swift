//
//  MainViewController.swift
//  Sample Task
//
//  Created by User on 13/07/21.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    
    var isState : Bool?
    var nextState : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isState == true
        {
            if Singleton.sharedInstance.newDataArray.count > 0
            {
                mainTableView.isHidden = false
                mainTableView.reloadData()
            }
        }
        else
        {
            mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isState == true
        {
            return Singleton.sharedInstance.newDataArray.count
        }
        else
        {
            return Singleton.sharedInstance.dataArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = (mainTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell)!
        if isState == true
        {
            cell.headingLabel?.text = Singleton.sharedInstance.newDataArray[indexPath.row]
            cell.mainImageView?.image = UIImage(named:Singleton.sharedInstance.newDataArray[indexPath.row])
        }
        else
        {
            cell.headingLabel?.text = Singleton.sharedInstance.dataArray[indexPath.row]
            cell.mainImageView?.image = UIImage(named:Singleton.sharedInstance.dataArray[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isStatus = isState! ? "Move to Available" : "Move to Loaned"
        let myAction = UIContextualAction.init(style: .normal, title: isStatus) { [self]_,_,_ in
            mainTableView.beginUpdates()
            if isState == true
            {
            Singleton.sharedInstance.dataArray.append(Singleton.sharedInstance.newDataArray[indexPath.row])
            Singleton.sharedInstance.newDataArray.remove(at: indexPath.row)
            }
            else
            {
            Singleton.sharedInstance.newDataArray.append(Singleton.sharedInstance.dataArray[indexPath.row])
            Singleton.sharedInstance.dataArray.remove(at: indexPath.row)
            }
            mainTableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
            mainTableView.endUpdates()
           }
        myAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration.init(actions: [myAction])
    }
}
