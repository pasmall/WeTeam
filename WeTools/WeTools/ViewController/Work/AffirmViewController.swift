//
//  AffirmViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/21.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class AffirmViewController: BaseViewController , FSCalendarDataSource, FSCalendarDelegate {

    private weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: self.view.bounds.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        calendar.scopeGesture.isEnabled = true
        self.view.addSubview(calendar)
        self.calendar = calendar
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
    
    // Update your frame
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendar.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: bounds.width, height: bounds.height)
    }

}
