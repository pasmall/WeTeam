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
        newBtn.addTarget(self, action: #selector(LoginViewController.tapLoginBtn), for: .touchUpInside)
        view.addSubview(newBtn)
        
        
        
        
        
    }
    
    func tapLoginBtn() {
        
        //登录融云服务器的token。需要您向您的服务器请求，您的服务器调用server api获取token
        //开发初始阶段，您可以先在融云后台API调试中获取
        let token = "fvDs0lf7IpOjkVWzvizywmG94AHbiI5IElva12HJH7/+S9MZb47xNVnEb8uR72K9unN8O+SykY4="
        
        //连接融云服务器
        RCIM.shared().connect(withToken: token,
                              success: { (userId) -> Void in
                                print("登陆成功。当前登录的用户ID：\(userId)")
                                
                                
                                
                                
                                //设置当前登陆用户的信息
                                RCIM.shared().currentUserInfo = RCUserInfo.init(userId: userId, name: "聂自强", portrait: "http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=qq动漫头像%20男生&step_word=&hs=0&pn=35&spn=0&di=108008139580&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=2337318174%2C937294706&os=3270262304%2C2412685266&simid=4245532796%2C821268613&adpicid=0&ln=1996&fr=&fmq=1478139885783_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fp2.gexing.com%2FG1%2FM00%2F20%2F6D%2FrBACE1O-SaLhGj3IAAAeJDAhwQI934_200x200_3.jpg%3Frecache%3D20131108&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3B2jxtg2_z%26e3Bv54AzdH3Fqqp57xtwg2AzdH3Fnn9dcnc_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0")
                                
                                DispatchQueue.main.sync(execute: { () -> Void in
                                    //打开会话列表
                                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                    appdelegate.window?.rootViewController = BaseTabBarViewController()
                                    
                                    
                                    //                                    let chatListView = DemoChatListViewController()
                                    //                                    self.navigationController?.pushViewController(chatListView, animated: true)
                                })
            }, error: { (status) -> Void in
                
                
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                
                
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
        
        
        
        
        
        
    }
    
    
    
}
