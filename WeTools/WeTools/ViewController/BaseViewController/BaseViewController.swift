//
//  BaseViewController.swift
//  简易管理
//
//  Created by lhtb on 16/10/27.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {

    var alert = SweetAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showMessage(mes:String) {
       _ = SweetAlert().showAlert(mes)
    }
    
    func subtitleAlert(mes:String , subtitle:String,style: AlertStyle )  {
        _ = SweetAlert().showAlert(mes, subTitle: subtitle, style: AlertStyle.success)
    }
    
    
    
     func warningAlert(_ sender: AnyObject) {
        _ = SweetAlert().showAlert("Are you sure?", subTitle: "You file will permanently delete!", style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes, delete it!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Cancel Button  Pressed", terminator: "")
            }
            else {
                _ = SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.success)
            }
        }
    }
    
     func cancelAndConfirm(_ sender: AnyObject) {
        _ = SweetAlert().showAlert("Are you sure?", subTitle: "You file will permanently delete!", style: AlertStyle.warning, buttonTitle:"No, cancel plx!", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes, delete it!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                _ = SweetAlert().showAlert("Cancelled!", subTitle: "Your imaginary file is safe", style: AlertStyle.error)
            }
            else {
                _ = SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.success)
            }
        }
        
    }
    
     func customIconAlert(_ sender: AnyObject) {
        _ = SweetAlert().showAlert("Sweet!", subTitle: "Here's a custom image.", style: AlertStyle.customImag(imageFile: "thumb.jpg"))
    }

}
