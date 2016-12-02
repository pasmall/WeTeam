//
//  TaskCell.swift
//  WeTools
//
//  Created by lhtb on 2016/11/25.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var line: UIView!
    @IBOutlet weak var lineimg: UIImageView!
    @IBOutlet weak var bgimg: UIImageView!
    @IBOutlet weak var timelab: UILabel!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var conLab: UILabel!
    
//    var taskinfo:TaskModel =  {
//    
//        didSet{
//        
//        
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        lineimg.layer.cornerRadius = 10
        lineimg.layer.masksToBounds = true
        
        
        let insets = UIEdgeInsetsMake(20, 25, 20, 25)
        let img = UIImage.init(named: "bgtask")
        bgimg.image = img?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
