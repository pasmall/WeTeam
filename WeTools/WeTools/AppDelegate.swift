//
//  AppDelegate.swift
//  WeTools
//
//  Created by lhtb on 16/11/1.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,RCIMConnectionStatusDelegate, RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMReceiveMessageDelegate{
    
    
    let RC_APPKEY = "vnroth0krtymo"
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //注册融云SDK
        RCIM.shared().initWithAppKey(RC_APPKEY)
        
        //设置监听连接状态
        RCIM.shared().connectionStatusDelegate = self
        //设置消息接收的监听
        RCIM.shared().receiveMessageDelegate = self
        
        //设置用户信息提供者，需要提供正确的用户信息，否则SDK无法显示用户头像、用户名和本地通知
        RCIM.shared().userInfoDataSource = self
        //设置群组信息提供者，需要提供正确的群组信息，否则SDK无法显示群组头像、群名称和本地通知
        RCIM.shared().groupInfoDataSource = self
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())    
        window?.makeKeyAndVisible()
        
        
        
        IQKeyboardManager.sharedManager().enable = true
        // Override point for customization after application launch.
        return true
    }
    
    
    
    
    
    
    
    //监听连接状态变化
    func onRCIMConnectionStatusChanged(_ status: RCConnectionStatus) {
        print("RCConnectionStatus = \(status.rawValue)")
    }
    
    //用户信息提供者。您需要在completion中返回userId对应的用户信息，SDK将根据您提供的信息显示头像和用户名
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        print("用户信息提供者，getUserInfoWithUserId:\(userId)")

        //简单的示例，根据userId获取对应的用户信息并返回
        //建议您在本地做一个缓存，只有缓存没有该用户信息的情况下，才去您的服务器获取，以提高用户体验
        
        
        if (userId == "me") {
            //如果您提供的头像地址是http连接，在iOS9以上的系统中，请设置使用http，否则无法正常显示
            //具体可以参考Info.plist中"App Transport Security Settings->Allow Arbitrary Loads"
            completion(RCUserInfo(userId: userId, name: "我的名字", portrait: "http://www.rongcloud.cn/images/newVersion/logo/baixing.png"))
        } else if (userId == "you") {
            completion(RCUserInfo(userId: userId, name: "你的名字", portrait: "http://www.rongcloud.cn/images/newVersion/logo/qichezc.png"))
        } else {
            
            Alamofire.request(IP + "userwithid.php", method: .post, parameters: ["userid":userId]).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    
                    let dic = json["data"] as! Array<Dictionary<String,Any>>
                    print(dic)
                    
                    completion(RCUserInfo(userId: userId, name: dic[0]["user_name"] as! String , portrait: IP + "img/000.jpg"))
                    
                    }
                }
            }
        }
    }
    
    //群组信息提供者。您需要在Block中返回groupId对应的群组信息，SDK将根据您提供的信息显示头像和群组名
    func getGroupInfo(withGroupId groupId: String!, completion: ((RCGroup?) -> Void)!) {
        print("群组信息提供者，getGroupInfoWithGroupId:\(groupId)")
        
        //简单的示例，根据groupId获取对应的群组信息并返回
        //建议您在本地做一个缓存，只有缓存没有该群组信息的情况下，才去您的服务器获取，以提高用户体验
        if (groupId == "group01") {
            //如果您提供的头像地址是http连接，在iOS9以上的系统中，请设置使用http，否则无法正常显示
            //具体可以参考Info.plist中"App Transport Security Settings->Allow Arbitrary Loads"
            completion(RCGroup(groupId: groupId, groupName: "第一个群", portraitUri: "http://www.rongcloud.cn/images/newVersion/logo/aipai.png"))
        } else {
            completion(RCGroup(groupId: groupId, groupName: "unknown", portraitUri: "http://www.rongcloud.cn/images/newVersion/logo/qiugongl.png"))
        }
    }
    
    //监听消息接收
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        if (left != 0) {
            print("收到一条消息，当前的接收队列中还剩余\(left)条消息未接收，您可以等待left为0时再刷新UI以提高性能")
        } else {
            print("收到一条消息")
        }
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

