//
//  WorkViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/3.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class WorkViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource{

    var tableView:UITableView! = nil
    var refreshControl: UIRefreshControl!
    var timer : Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUI(){
        
        self.navigationItem.title = "事务"
        

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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: WorkCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! WorkCell
        cell.accessoryType = .disclosureIndicator
        
        cell.icon.image = UIImage.init(named: "icon")
        cell.title.text = "我要说点什么鬼啊"
        cell.des.text = "safhdskhfdsjkfhdjksahfjdshbfdjksfhdjsfhndsa"
        
        cell.icon.layer.cornerRadius = 5
        cell.icon.layer.borderWidth = 1
        cell.icon.layer.borderColor = UIColor.getColor(r: 243, g: 243, b: 243).cgColor
        cell.icon.layer.masksToBounds = true
        cell.icon.contentMode = .scaleAspectFit
        
        
        let line  = UIView.init(frame: CGRect.init(x: 64, y: cell.height - 1, width: SCREEN_WIDTH - 64, height: 1))
        line.backgroundColor = backColor
        cell.addSubview(line)
        
        
        
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    
        return 84
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            doSomething()
        }
    }
    
    func doSomething() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(WorkViewController.endOfWork), userInfo: nil, repeats: false)
    }
    
    func endOfWork() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }
    
}
