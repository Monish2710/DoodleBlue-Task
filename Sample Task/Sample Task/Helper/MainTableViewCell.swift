//
//  MainTableViewCell.swift
//  Sample Task
//
//  Created by User on 13/07/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var textPriceLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.masksToBounds = false
        baseView.layer.shadowOffset = CGSize(width: -1, height: 1)
        baseView.layer.shadowRadius = 1
        baseView.layer.shadowOpacity = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

final class Singleton: NSObject
{
   static let sharedInstance = Singleton()
    private override init() { }
    var dataArray = ["Australia", "Brazil", "Canada","China","Germany","India","Malaysia", "Pakistan", "Russia", "Singapore"]
    var newDataArray = [String]()
}
