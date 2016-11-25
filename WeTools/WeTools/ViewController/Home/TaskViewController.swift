//
//  TaskViewController.swift
//  简易管理
//
//  Created by lhtb on 16/10/28.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class TaskViewController: RCConversationListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue,
                                          RCConversationType.ConversationType_DISCUSSION.rawValue,
                                          RCConversationType.ConversationType_CHATROOM.rawValue,
                                          RCConversationType.ConversationType_GROUP.rawValue,
                                          RCConversationType.ConversationType_APPSERVICE.rawValue,
                                          RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue,
                                           RCConversationType.ConversationType_CHATROOM.rawValue,
                                           RCConversationType.ConversationType_GROUP.rawValue,
                                           RCConversationType.ConversationType_APPSERVICE.rawValue,
                                           RCConversationType.ConversationType_SYSTEM.rawValue])
        
        self.navigationItem.title = "最近会话列表"
        
        let btn = UIButton()
        btn.frame = CGRect.init(x: 0, y: 0, width: 44 , height: 44)
        btn.setImage(UIImage.init(named: "ms_add"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem.init(customView: btn)
        btn.addTarget(self, action: #selector(TaskViewController.privateChat), for: .touchUpInside)
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "联系人", style: .plain, target: self, action: #selector(TaskViewController.tapLeftbtn))
        
        
        
//        conversationListTableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapLeftbtn() {
        let VC =  FriendViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func privateChat() {
        //打开会话界面
        let chatWithSelf = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "5")
        chatWithSelf?.title = "想显示的会话标题"
        self.navigationController?.pushViewController(chatWithSelf!, animated: true)
    }
    
    
    //重写RCConversationListViewController的onSelectedTableRow事件
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        //打开会话界面
        let chat = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId)
        chat?.title = "好友"
        self.navigationController?.pushViewController(chat!, animated: true)
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
