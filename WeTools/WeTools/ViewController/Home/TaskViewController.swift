//
//  TaskViewController.swift
//  简易管理
//
//  Created by lhtb on 16/10/28.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class TaskViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loginRongCloud() {
        //登录融云服务器的token。需要您向您的服务器请求，您的服务器调用server api获取token
        //开发初始阶段，您可以先在融云后台API调试中获取
        let token = "OHvNZQPCl8d9xFBV6hYuyn3KWcePBCPg0uDKhMccdAOuTDtWZugh9AtgyVimggIZaZtCVyTc8sWNAeH0EzC2oA=="
        
        //连接融云服务器
        RCIM.shared().connect(withToken: token,
                              success: { (userId) -> Void in
                                print("登陆成功。当前登录的用户ID：\(userId)")
                                
                                //设置当前登陆用户的信息
                                RCIM.shared().currentUserInfo = RCUserInfo.init(userId: userId, name: "我的名字", portrait: "http://www.rongcloud.cn/images/newVersion/logo/baixing.png")
                                
                                DispatchQueue.main.sync(execute: { () -> Void in
                                    //打开会话列表
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
