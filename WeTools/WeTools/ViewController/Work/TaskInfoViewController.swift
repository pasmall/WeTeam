//
//  TaskInfoViewController.swift
//  WeTools
//
//  Created by lhtb on 2016/11/25.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class TaskInfoViewController: BaseViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    var proname:String = ""
    var pro_id:String = ""
    var pro_creator:String = ""
    
    
    var tableView:UITableView! = nil
    var refreshControl: UIRefreshControl!
    var dataArr:Array<Any> = []{
        didSet{
            endOfWork()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUI()
        getDataInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDataInfo()  {
        
//        dataArr = ["sdsdsdahsjkhjkfhjhdsafhdjsfhdsajksdjkfhbdsfjdhsfdhsjfkdhsfjkdsakfjdsjkf" ,"sdasdkljasildjaskldjaslkdjaslkdjalsdjaklsdjasd深刻理解啦开始的骄傲收款打款时间呢萨克雷达上看了的金卡是肯定卡死了都卡死；打开 撒打算了；看 了；打卡上了；的卡洛斯；打卡上；来得快","sdsdsadas","sdsdsd"]
//        
        
        NetHelper.custom.request(IP + "gettask.php", method: .post, parameters:  ["proid":self.pro_id]).responseJSON { (jsondata) in
            if let json = jsondata.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    print(json["data"] as Any)
                    
                    var muarr = Array<Any>()
                    
                    
                    for dic in json["data"] as! Array<Dictionary<String,Any>> {
                        
                       muarr.append(TaskModel.init(dic: dic))
                    
                    }
                    
                    self.dataArr = muarr
                    print(muarr)
                    self.tableView.reloadData()
                }else{
                    self.endOfWork()
                }
            
            }
        }
    }
    
    
    func setUI(){
  
        
        
        tableView = UITableView.init(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = blueColor
        tableView.addSubview(refreshControl)
        
        
        
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        let icon = UIImageView.init(frame: CGRect.init(x: 10, y: 16, width: 44, height: 44))
        icon.image = UIImage.init(named: "icon")
        headerView.addSubview(icon)
        icon.layer.cornerRadius = 22
        icon.layer.borderWidth = 2
        icon.layer.borderColor = blueColor.cgColor
        icon.layer.masksToBounds = true
        
        
        let namelab = UILabel.init(frame: CGRect.init(x: 70, y: 16, width: 100, height: 44))
        namelab.text = "我就是我啊"
        namelab.font = UIFont.systemFont(ofSize: 14)
        headerView.addSubview(namelab)
        
        NetHelper.custom.request(IP + "userwithid.php", method: .post, parameters: ["userid":self.pro_creator]).responseJSON { (returnData) in
            
            if let json = returnData.result.value as? [String:Any]{
                if json["code"] as! Int == 200 {
                    print(json["data"] as Any)
                    
                    let dic = json["data"] as! Array<Dictionary<String,Any>>
                    namelab.text = dic[0]["user_name"] as! String?
                    NetHelper.custom.request(dic[0]["user_icon"] as! String, method: .get).responseData { (data) in
                        icon.image = UIImage.init(data: data.data!)
                    }
                }
                
            }
            
        }
        
        
        tableView.tableHeaderView = headerView
        
        
        self.navigationItem.title = self.proname
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "添加", style: .done, target: self, action: #selector(tapNext))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
        
//        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
//        let data = self.dataArr[indexPath.row] as! Dictionary<String,Any>
        
        let cell: TaskCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskCell
//        cell.accessoryType = .disclosureIndicator
        
//        cell.icon.image = UIImage.init(named: "icon")
//        cell.title.text = data["pro_name"] as! String?
//        cell.des.text = data["pro_des"] as! String?
//        
//        cell.icon.layer.cornerRadius = 5
//        cell.icon.layer.borderWidth = 1
//        cell.icon.layer.borderColor = UIColor.getColor(r: 243, g: 243, b: 243).cgColor
//        cell.icon.layer.masksToBounds = true
//        cell.icon.contentMode = .scaleAspectFit
//        
//        
//        let line  = UIView.init(frame: CGRect.init(x: 64, y: cell.height - 1, width: SCREEN_WIDTH - 64, height: 1))
//        line.backgroundColor = backColor
//        cell.addSubview(line)
        
        self.configCell(cell: cell , indexPath: indexPath)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
       return tableView.fd_heightForCell(withIdentifier: "cell", configuration: { (cell) in
            self.configCell(cell: cell as! TaskCell, indexPath: indexPath)
       })
       
    }
    
    func configCell(cell:TaskCell , indexPath:IndexPath) {
        let data = self.dataArr[indexPath.row] as! TaskModel
        
        
        cell.conLab.text = data.task_des
        cell.timelab.text = data.task_end
        
        if data.task_end == "1" {
        
            cell.typeBtn.setTitle("待处理", for: .normal)
        }else if data.task_end == "0" {
        
            cell.typeBtn.setTitle("已完成", for: .normal)
        }else{
            cell.typeBtn.setTitle("处理中", for: .normal)
        }
        
        
        
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            getDataInfo()
        }
    }
    
    
    func endOfWork() {
        refreshControl.endRefreshing()
    }
    
    
    func tapNext()  {
        
        self.navigationController?.pushViewController(AddTaskViewController(), animated: true)
        
    }

}
