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
        
        tableView = UITableView.init(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "WorkCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        
        
        
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
    
}
