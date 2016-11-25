//
//  LoginViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/2.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: BaseViewController {
    
    
    
    let user_icon  = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 64, height: 64))
    let accTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 140, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入账号")
    let psdTF = LoginTextField.init(frame: CGRect.init(x: 0, y: 184, width: SCREEN_WIDTH, height: 44), placeholderStr: "请输入密码")
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backColor
        self.navigationItem.title = "登录"
        self.setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
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
        forgetBtn.titleLabel?.font = UIFont.Helvetica(size: 14)
        forgetBtn.addTarget(self, action: #selector(LoginViewController.tapLoginBtn), for: .touchUpInside)
        view.addSubview(forgetBtn)
        
        //新用户注册
        let newBtn = UIButton()
        newBtn.frame = CGRect.init(x: SCREEN_WIDTH - 110, y: SCREEN_HEIGHT - 54 , width: 100 , height: 44)
        newBtn.setTitle("新用户注册", for: .normal)
        newBtn.setTitleColor(blueColor, for: .normal)
        newBtn.contentHorizontalAlignment = .right
        newBtn.titleLabel?.font = UIFont.Helvetica(size: 14)
        newBtn.addTarget(self, action: #selector(LoginViewController.topReist), for: .touchUpInside)
        view.addSubview(newBtn)
        
        
        
    }
    
     func topReist(){
        
        let registVC = RegistViewController()
        
        self.navigationController?.pushViewController(registVC, animated: true)
        
    
    }
    
    
    func tapLoginBtn() {
        
        
//        NetWork.shareNetWork().startRequest(urlStr: "http://127.0.0.1/api/userinfo.php", method: .POST, param: ["name":accTF.text,"psd":psdTF.text], callBack: nil)
        
        self.showSimpleHUD()
        NetHelper.custom.request(IP + "userinfo.php", method: .post, parameters: ["name":accTF.text!,"psd":psdTF.text!]).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    if (json["data"] as? [String:Any] ) != nil{
                        
                        let userinfo = json["data"] as? [String:Any]
                        
                        //连接融云服务器
                        RCIM.shared().connect(withToken: userinfo?["user_token"] as! String,
                                              success: { (userId) -> Void in
                                                print("登陆成功。当前登录的用户ID：\(userId)")
                                                
                                                
                                                UserInfo.sharedInstance.user_id = userId!
                                                UserInfo.sharedInstance.user_name = userinfo?["user_name"] as! String
                                                UserInfo.sharedInstance.user_psd = self.psdTF.text!
                                                UserInfo.sharedInstance.user_icon = IP + "img/000.jpg"
                                                
                                                //设置当前登陆用户的信息
                                                RCIM.shared().currentUserInfo = RCUserInfo.init(userId: userId , name: userinfo?["user_name"] as! String, portrait: IP + "img/000.jpg")
                                                
                                                DispatchQueue.main.sync(execute: { () -> Void in
                                                    
                                                    self.hidSimpleHUD()
                                                    //打开会话列表
                                                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                                    appdelegate.window?.rootViewController = BaseTabBarViewController()
                                                    
                                                })
                        }, error: { (status) -> Void in
                            
                            
                            print("登陆的错误码为:\(status.rawValue)")
                        }, tokenIncorrect: {
                            //token过期或者不正确。
                            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                            print("token错误")
                        })
                        
                    }else{
                        self.hidSimpleHUD()
                         _ = self.alert.showAlert(json["message"] as! String)
                    }
                }else{
                
                    self.hidSimpleHUD()
                }
            }
            
        }
        
        
        
        
        
        
       
        
        
        
        
        
        
    }
    
    
    
}
