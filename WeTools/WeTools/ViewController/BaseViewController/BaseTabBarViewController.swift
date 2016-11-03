//
//  BaseTabBarViewController.swift
//  简易管理
//
//  Created by lhtb on 16/10/27.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setUI() {
        addChildVC(childController: TaskViewController(), title: "消息", imageName: "chat_tab")
        addChildVC(childController: WorkViewController(), title: "事务", imageName: "discovery_tab")
        addChildVC(childController: BaseViewController(), title: "我的", imageName: "account_tab")
        
    }
    
    
    func addChildVC(childController: UIViewController? , title: String! ,imageName : String!) {
        
        childController?.tabBarItem.image = UIImage(named: imageName)
        childController?.tabBarItem.selectedImage = UIImage(named: imageName + "2")
        childController?.tabBarItem.title = title
        
        childController?.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
        let nav = BaseNavigationController(rootViewController: childController!)
        addChildViewController(nav)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    
    
    
    
}
