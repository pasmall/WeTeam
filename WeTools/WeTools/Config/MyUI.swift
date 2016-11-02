//
//  MyUI.swift
//  WeTools
//
//  Created by lhtb on 16/11/2.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import Foundation
import UIKit

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, placeholderStr: String) {
        self.init(frame: frame)
        clearButtonMode = .whileEditing
        backgroundColor = UIColor.white
        placeholder = placeholderStr
        
        self.textAlignment = .center
        
        let left = UIView()
        left.frame = CGRect.init(x: 0, y: 0, width: 40, height: self.height)
        left.contentMode = .center
        leftView = left
        leftViewMode = .always
        
        let right = UIView()
        right.frame = CGRect.init(x: 0, y: 0, width: 40, height: self.height)
        right.contentMode = .center
        rightView = right
        rightViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
