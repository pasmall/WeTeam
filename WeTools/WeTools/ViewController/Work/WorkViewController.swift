//
//  WorkViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/3.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Alamofire

class WorkViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource{

    var tableView:UITableView! = nil
    var refreshControl: UIRefreshControl!
    var dataArr:Array<Any> = []{
        didSet{
            endOfWork()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDataInfo()
    }
    
    func getDataInfo()  {
        Alamofire.request(IP + "getproject.php" , method: .post, parameters: nil).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    print(json["data"] as Any)
                    self.dataArr = json["data"] as! Array<Any>
                    self.tableView.reloadData()
                }
            }
        }
      
    }
    

    func setUI(){
        
        self.navigationItem.title = "项目列表"
        

        createNavRightMenu(right: UIImage.init(named: "work_add")!)
        
        
        tableView = UITableView.init(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "WorkCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        
//        let header  = UIView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
//        tableView.tableHeaderView = header
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = blueColor
        tableView.addSubview(refreshControl)
        
        
        rightBtn.addTarget(self, action: #selector(WorkViewController.tapRightBtn), for: .touchUpInside)
        
    }
    
    func tapRightBtn()  {
        
        self.navigationController?.pushViewController(AddWorkViewController(), animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let data = self.dataArr[indexPath.row] as! Dictionary<String,Any>
        
        let cell: WorkCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! WorkCell
        cell.accessoryType = .disclosureIndicator
        
//        cell.icon.image = UIImage.init(named: "icon")
        
        NetHelper.custom.request(data["pro_icon"] as! String, method: .get).responseData { (data) in
            cell.icon.image = UIImage.init(data: data.data!)
        }
        
        cell.title.text = data["pro_name"] as! String?
        cell.des.text = data["pro_des"] as! String?
        
        cell.icon.layer.cornerRadius = 5
        cell.icon.layer.borderWidth = 1
        cell.icon.layer.borderColor = UIColor.getColor(r: 243, g: 243, b: 243).cgColor
        cell.icon.layer.masksToBounds = true
        cell.icon.contentMode = .scaleAspectFit
        
        
        let line  = UIView.init(frame: CGRect.init(x: 64, y: cell.height - 1, width: SCREEN_WIDTH - 64, height: 1))
        line.backgroundColor = backColor
        cell.addSubview(line)
        
        
        
        cell.selectionStyle = .none
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    
        return 84
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.dataArr[indexPath.row] as! Dictionary<String,Any>
        
        let taskVc = TaskInfoViewController()
        taskVc.proname = data["pro_name"] as! String
        taskVc.pro_id = data["pro_id"] as! String
        taskVc.pro_creator = data["pro_creator"] as! String
        self.navigationController?.pushViewController(taskVc, animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            getDataInfo()
        }
    }
    
    
    func endOfWork() {
        refreshControl.endRefreshing()
    }
    
}
