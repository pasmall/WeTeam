//
//  NetHelper.swift
//  WeTools
//
//  Created by lhtb on 2016/11/24.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire


enum RequestType:Int {
    case RequestTypeGET
    case RequestTypePOST
}

//创建闭包
typealias sendVlesClosure = (AnyObject?, NSError?)->Void
typealias uploadClosure = (AnyObject?, NSError?,Int64?,Int64?,Int64?)->Void


class NetHelper: SessionManager {
    
    
    open static let `custom`: NetHelper = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return NetHelper(configuration: configuration)
    }()
    
    // --POST请求获取JSON数据

    func PostJSONDataWithUrl(url: String, parameters: Dictionary<String,Any>, successed:@escaping (_ responseObject: AnyObject?) -> (), failed: @escaping (_ error: NSError?) -> ()) {
        
        
        NetHelper.custom.request(IP + url, method: .post, parameters: parameters ).responseJSON { (data) in
            
            if data.result.isSuccess {
                successed(data.data as AnyObject?)
            }else {
                failed(data.result.error as NSError?)
            }
            
        }
        
    }
    

}

