//
//  NetWork.swift
//  简易管理
//
//  Created by lhtb on 16/10/28.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit



let homeUrl = "https:127.0.0.1"

enum reqType {
    case POST
    case GET
}


class NetWork: NSObject {
    
    
    
    private static let tool:NetWork = {
        
        let t = NetWork()
        
        return t
    }()
    
    class func shareNetWork()->NetWork {
        return tool
    }
    
    func startRequest(urlStr:String , method:reqType ,param:[String: Any] ,callBack:( @escaping (Any? ,Error?) ->()))  {
        
        //发起post请求
        if method == .POST {
            
            //1.创建请求
            var req = URLRequest(url: URL.init(string: urlStr)!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0)
            req.httpMethod = "POST"
            
            //2.创建任务
            
            
            let session = URLSession.shared
            let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
                
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with:data!, options:.mutableContainers ) as! NSDictionary
                    callBack(jsonData,nil)
                    print( "BBB", jsonData)
                } catch {
                    print("解析失败")
                }

               
            })
           
            task.resume()
            
            
            
        }else{
        
        
        
        }
        
        
        
    }
        
        
        
    
    
    

}
