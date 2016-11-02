//
//  LoginViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/2.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    let user_icon  = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 64, height: 64))
    let accTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 140, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入账号")
    let psdTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 184, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入密码")
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backColor
        self.setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUI(){
        
        view.addSubview(user_icon)
        view.addSubview(accTF)
        view.addSubview(psdTF)
        
        
        
        let line  = UIView.init(frame: CGRect.init(x: 0, y: 184, width: SCREEN_WIDTH, height: 0.4))
        line.backgroundColor = backColor
        view.addSubview(line)
        
        
        //头像设置
        user_icon.setCenterX(cx: SCREEN_WIDTH * 0.5)
        user_icon.setY(y: 44)
        user_icon.layer.cornerRadius = 32
        user_icon.layer.masksToBounds = true
        user_icon.image = UIImage(named: "icon")
        user_icon.contentMode = .scaleAspectFit
        
        psdTF.isSecureTextEntry = true
        
        //登录
        let logBtn = UIButton()
        logBtn.frame = CGRect.init(x: 10, y: 248, width: SCREEN_WIDTH - 20, height: 44)
        logBtn.backgroundColor = blueColor
        logBtn.setTitle("登录", for: .normal)
        logBtn.layer.cornerRadius = 4
        logBtn.layer.masksToBounds = true
        logBtn.addTarget(self, action: #selector(LoginViewController.tapLoginBtn), for: .touchUpInside)
        view.addSubview(logBtn)
        
        //无法登录
        let forgetBtn = UIButton()
        forgetBtn.frame = CGRect.init(x: 10, y: SCREEN_HEIGHT - 54 , width: 100 , height: 44)
        forgetBtn.setTitle("无法登录？", for: .normal)
        forgetBtn.setTitleColor(blueColor, for: .normal)
        forgetBtn.contentHorizontalAlignment = .left
        forgetBtn.titleLabel?.font = UIFont.Helvetica(size: 12)
        forgetBtn.addTarget(self, action: #selector(LoginViewController.tapLoginBtn), for: .touchUpInside)
        view.addSubview(forgetBtn)
        
        //新用户注册
        
        
        
        
        
        
    }
    
    func tapLoginBtn() {
        
    }
    
    
    
}
