//
//  AffirmViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/21.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class AffirmViewController: BaseViewController , FSCalendarDataSource, FSCalendarDelegate ,UICollectionViewDelegate , UICollectionViewDataSource{
    
    var cont = ""
    private weak var calendar: FSCalendar!
    
    var dataArr = Array<Any>()
    var collectionView :UICollectionView!
    var tit2:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataInfo()
        
        self.navigationItem.title = "指派"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .done, target: self, action: #selector(tapNext))
        
        
        let tit1 = UILabel.init(frame: CGRect.init(x: 5, y: 64, width: 200, height: 21))
        tit1.text = "指派任务到:"
        tit1.font = UIFont.systemFont(ofSize: 12, weight: 1)
        view.addSubview(tit1)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH  / 6.0, height: 80)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 85, width: SCREEN_WIDTH, height: 80), collectionViewLayout:layout )
        let cellNib = UINib(nibName: "MineCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "myCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        
        tit2 = UILabel.init(frame: CGRect.init(x: 5, y: collectionView.frame.maxY + 10, width: 200, height: 21))
        tit2.text = "指派完成时间:"
        tit2.font = UIFont.systemFont(ofSize: 12, weight: 1)
        view.addSubview(tit2)
        

        let calendar = FSCalendar(frame: CGRect(x: 0, y: tit2.frame.maxY, width: self.view.bounds.width, height: 300))
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
    
    func tapNext()  {
        
    }
    
    
    func getDataInfo()  {
        NetHelper.custom.request(IP + "getusers.php" , method: .post, parameters: nil).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    self.dataArr = json["data"] as! Array<Any>
                    self.collectionView.reloadData()
                }
            }
        }
    }

    /*
     *UICollectionView
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MineCollectionViewCell
        let dic = dataArr[indexPath.row] as! Dictionary<String,Any>
        
        
        cell.img.image = UIImage(named: "mine_favourite")
        cell.titlelab.text = dic["user_name"] as? String
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.backgroundColor = UIColor.red
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! MineCollectionViewCell
//        if cell.selectimg.isHidden {
//            cell.selectimg.isHidden = false
//        }else{
//            cell.selectimg.isHidden = true
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MineCollectionViewCell
        if cell.selectimg.isHidden {
            cell.selectimg.isHidden = false
        }else{
            cell.selectimg.isHidden = true
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MineCollectionViewCell
        cell.selectimg.isHidden = true
    }
    // Update your frame
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendar.frame = CGRect(x: 0, y: self.tit2.frame.maxY, width: bounds.width, height: bounds.height)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }

}
