//
//  AddWorkViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/4.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class AddWorkViewController: BaseViewController , UITextViewDelegate {
    
    
    let  nameTF  = UITextField()
    let conTF = UITextView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "创建项目"
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .done, target: self, action: #selector(AddWorkViewController.tapNext))
        
        setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        
        let attStr = NSMutableAttributedString.init(string: "请输入项目名称")
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange.init(location: 0, length: attStr.length))
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSRange.init(location: 0, length: attStr.length))
        nameTF.frame = CGRect.init(x: 8, y: 64, width: SCREEN_WIDTH - 16, height: 60)
        nameTF.font = UIFont.systemFont(ofSize: 20)
        nameTF.attributedPlaceholder = attStr
        self.view.addSubview(nameTF)
        
        let line  = UIView()
        line.backgroundColor = backColor
        line.frame = CGRect.init(x: 5, y: 125, width: SCREEN_WIDTH - 10, height: 1)
        self.view.addSubview(line)
        
        
        conTF.frame = CGRect.init(x: 5, y: 126, width: SCREEN_WIDTH - 10, height: SCREEN_HEIGHT - 126)
        conTF.font = UIFont.systemFont(ofSize: 15)
        conTF.delegate = self
        conTF.text = "请输入项目介绍"
        self.view.addSubview(conTF)
        
        
        
    
    }
    
    
    func tapNext()  {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请输入项目介绍" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "请输入项目介绍"
        }
    }
    
    

}
