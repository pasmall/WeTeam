//
//  BaseViewController.swift
//  简易管理
//
//  Created by lhtb on 16/10/27.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    

    var alert = SweetAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     navBar
     */
    
    func createNavLeftMenu(left:AnyObject, withTarget: ( @escaping () ->())){

        
        if (left.isKind(of: NSString.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
            btn.setTitle(left as? String, for: .normal)
            btn.backgroundColor = UIColor.red
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.leftBarButtonItem = item
            
        }
        
       else if (left.isKind(of: UIImage.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 24 , height: 24)
            btn.setImage(left as? UIImage, for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.leftBarButtonItem = item
        }
        else if(left.isKind(of: UIView.self)){
        
            let item = UIBarButtonItem.init(customView: left as! UIView)
            self.navigationItem.leftBarButtonItem = item
        
        }
        
        
    }
    
    func tapLeft(){
        
    }
    
    
    /*
     消息提示
     */
    

}
