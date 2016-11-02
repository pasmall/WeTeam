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
        
        
//     self.showMessage(mes: "我日啊  sss")
    subtitleAlert(mes: "sdsdsd", subtitle: "sdsdsdsdsdsds", style: .success)
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

}
