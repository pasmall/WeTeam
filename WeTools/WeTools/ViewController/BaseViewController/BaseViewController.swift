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
    var leftBtn :UIButton! = nil
    var rightBtn :UIButton! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     navBar
     */
    
    func createNavLeftMenu(left:AnyObject){

        
        if (left.isKind(of: NSString.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
            btn.setTitle(left as? String, for: .normal)
            btn.setTitleColor(blueColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            leftBtn = btn
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.leftBarButtonItem = item
            
        }
        
       else if (left.isKind(of: UIImage.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 24 , height: 24)
            btn.setImage(left as? UIImage, for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            leftBtn = btn
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.leftBarButtonItem = item
        }
        else if(left.isKind(of: UIView.self)){
        
            let item = UIBarButtonItem.init(customView: left as! UIView)
            self.navigationItem.leftBarButtonItem = item
        
        }
        
        
    }
    
    
    func createNavRightMenu(right:AnyObject){
        
        
        if (right.isKind(of: NSString.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
            btn.setTitle(right as? String, for: .normal)
            btn.setTitleColor(blueColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            rightBtn = btn
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.rightBarButtonItem = item
            
        }
            
        else if (right.isKind(of: UIImage.self)) {
            let btn = UIButton()
            btn.frame = CGRect.init(x: 0, y: 0, width: 24 , height: 24)
            btn.setImage(right as? UIImage, for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            rightBtn = btn
            let item = UIBarButtonItem.init(customView: btn)
            self.navigationItem.rightBarButtonItem = item
        }
        else if(right.isKind(of: UIView.self)){
            
            let item = UIBarButtonItem.init(customView: right as! UIView)
            self.navigationItem.rightBarButtonItem = item
            
        }
        
        
    }
    
    
    
    /*
     消息提示
     */
    

}
