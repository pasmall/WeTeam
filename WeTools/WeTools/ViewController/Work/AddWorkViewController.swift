//
//  AddWorkViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/4.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class AddWorkViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "创建项目"
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .done, target: self, action: #selector(AddWorkViewController.tapNext))
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tapNext()  {
        
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
