//
//  AddTaskViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/30.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class AddTaskViewController: BaseViewController ,UITextViewDelegate {

    
    let conTF = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "添加任务"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .done, target: self, action: #selector(AddTaskViewController.tapNext))
        
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUI()  {
        
        
        
        let bgimg = UIImageView.init(frame: CGRect.init(x: 0, y: 69, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.5 - 10))
        let insets = UIEdgeInsetsMake(20, 25, 20, 25)
        let img = UIImage.init(named: "bgtask")
        bgimg.image = img?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        self.view.addSubview(bgimg)
        
        
        conTF.frame = CGRect.init(x: 5, y: 74, width: SCREEN_WIDTH - 10, height: SCREEN_HEIGHT * 0.5 - 20)
        conTF.font = UIFont.systemFont(ofSize: 15)
        conTF.text = "请输入任务内容"
        conTF.delegate = self
        self.view.addSubview(conTF)
    }
    
    func tapNext() {
        let aff = AffirmViewController()
        aff.cont = self.conTF.text
        self.navigationController?.pushViewController(aff, animated: true)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请输入任务内容" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "请输入任务内容"
        }
    }

}
