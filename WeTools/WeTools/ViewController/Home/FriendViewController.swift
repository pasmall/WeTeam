//
//  FriendViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/18.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire

class FriendViewController: BaseViewController ,UITableViewDataSource , UITableViewDelegate {

    
    var dataArr = Array<Any>()
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "同事列表"
        
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        getDataInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataInfo()  {
        Alamofire.request(IP + "getusers.php" , method: .post, parameters: nil).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    self.dataArr = json["data"] as! Array<Any>
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      var cell = tableView.dequeueReusableCell(withIdentifier:  "cell")
        
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        let dic = dataArr[indexPath.row] as! Dictionary<String,Any>
        
        cell?.imageView?.image = UIImage.init(named: "icon")
        cell?.textLabel?.text = dic["user_name"] as? String
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = dataArr[indexPath.row] as! Dictionary<String,Any>
        
        //打开会话界面
        let chat = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: dic["user_id"] as! String)
        chat?.title = dic["user_name"] as? String
        self.navigationController?.pushViewController(chat!, animated: true)
        
    }
    
    

}
