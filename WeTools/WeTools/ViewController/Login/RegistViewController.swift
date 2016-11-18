//
//  RegistViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/17.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire

class RegistViewController: BaseViewController {
    
    
    let accTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 140, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入手机号码")
    let psdTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 184, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入密码")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }

    func setUI ()  {
        view.addSubview(accTF)
        view.addSubview(psdTF)
        
        
        
        let line  = UIView.init(frame: CGRect.init(x: 0, y: 184, width: SCREEN_WIDTH, height: 0.4))
        line.backgroundColor = backColor
        view.addSubview(line)
        
        
        
        psdTF.isSecureTextEntry = true
        
        //登录
        let logBtn = UIButton()
        logBtn.frame = CGRect.init(x: 10, y: 248, width: SCREEN_WIDTH - 20, height: 44)
        logBtn.backgroundColor = blueColor
        logBtn.setTitle("注册", for: .normal)
        logBtn.layer.cornerRadius = 4
        logBtn.layer.masksToBounds = true
        logBtn.addTarget(self, action: #selector(LoginViewController.tapLoginBtn), for: .touchUpInside)
        view.addSubview(logBtn)
    }
    
    
    
    func tapLoginBtn()  {
        
        
        self.showSimpleHUD()
        Alamofire.request( IP + "regist.php", method: .post, parameters: ["name":accTF.text!,"psd":psdTF.text!]).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                
                print(json)
                if json["code"] as! Int == 200{
                    self.hidSimpleHUD()
                    
                 _ = self.alert.showAlert("", subTitle: "注册成功", style: AlertStyle.success, buttonTitle: "返回登录", action: { (true) in
                  _ = self.navigationController?.popViewController(animated: true)
                 })
                    
                } else if json["code"] as! Int == 202{
                
                   _ = self.alert.showAlert("该账号已被注册")
                }
            }
            
        }
        
    }
    
    
    
}
