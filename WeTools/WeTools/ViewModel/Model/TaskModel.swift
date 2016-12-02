//
//  TaskModel.swift
//  WeTools
//
//  Created by lhtb on 2016/11/25.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class TaskModel: NSObject {

    var task_id :String!
    var task_begin :String!
    var task_end :String!
    var task_des :String!
    var task_creator :String!
    var task_cur_type :String!
    var task_ture_end :String!
    var task_project :String!
    var task_userid :String!
    var task_username :String!
    
    
    
    init(dic:Dictionary<String , Any>) {
        super.init()
        setValuesForKeys(dic)
    }
}
