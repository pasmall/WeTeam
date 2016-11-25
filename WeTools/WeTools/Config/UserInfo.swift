//
//  UserInfo.swift
//  WeTools
//
//  Created by lhtb on 2016/11/23.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class UserInfo: NSObject {

    var user_id:String {
        
        didSet{
            
            UserDefaults.standard.set(user_id, forKey: "user_id")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    var user_name:String{
        
        didSet{
            
            UserDefaults.standard.set(user_name, forKey: "user_name")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    var user_psd:String{
    
            didSet{
    
                UserDefaults.standard.set(user_psd, forKey: "user_psd")
                UserDefaults.standard.synchronize()
            }
    
        }
    
    var user_icon:String{
        
        didSet{
            
            UserDefaults.standard.set(user_icon, forKey: "user_icon")
            UserDefaults.standard.synchronize()
        }
        
    }

    
    
    static let sharedInstance = UserInfo()
    private override init() {
        
        let user =  UserDefaults.standard.object(forKey: "user_id") as? String
        
        if  user != nil {
            user_id  = UserDefaults.standard.object(forKey: "user_id") as! String
            user_name = (UserDefaults.standard.object(forKey: "user_name") as? String)!
            user_psd = (UserDefaults.standard.object(forKey: "user_psd") as? String)!
            user_icon = (UserDefaults.standard.object(forKey: "user_icon") as? String)!
            
        }else{
            user_id = ""
            user_name = ""
            user_psd = ""
            user_icon = ""
        }
        
    }
    
    
    func dataClearing(){
        
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "user_name")
        UserDefaults.standard.removeObject(forKey: "user_psd")
        UserDefaults.standard.removeObject(forKey: "user_icon")
        UserDefaults.standard.synchronize()
        
        user_id = ""
        user_name = ""
        user_psd = ""
        user_icon = ""
        
    }
}
