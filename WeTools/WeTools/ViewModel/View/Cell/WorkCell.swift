//
//  WorkCell.swift
//  WeTools
//
//  Created by lhtb on 16/11/3.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class WorkCell: UITableViewCell {

    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
