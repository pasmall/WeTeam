//
//  MineViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/8.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController , UICollectionViewDelegate , UICollectionViewDataSource{

    
    let header = "headcell"
    let footer = "footercell"
    let user_icon  = UIImageView(frame: CGRect.init(x: 20, y: 64, width: 64, height: 64))
    
    var imgArr = [[String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = backColor
        
        getData()
        setUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getData () {
        imgArr = [ ["mine_download" , "mine_favourite" , "mine_gotPrise" , "mine_history" , "mine_pocketcenter","mine_setting" ,"mine_theme"] , ["mine_systemNotification" , "mine_shakeMe" ]]
    }
    
    func setUI() {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 164))
        view.addSubview(headerView)
        
        //头像设置
        user_icon.layer.cornerRadius = 32
        user_icon.layer.masksToBounds = true
        user_icon.image = UIImage(named: "icon")
        user_icon.contentMode = .scaleAspectFit
        headerView.addSubview(user_icon)
        
        
        
        
        
        
        
        
        
       
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize.init(width: SCREEN_WIDTH, height: 44)
        layout.footerReferenceSize = CGSize.init(width: SCREEN_WIDTH, height: 21)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH  / 4.0, height: 110)
        
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 164, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 164), collectionViewLayout:layout )
        let cellNib = UINib(nibName: "MineCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "myCell")
        collectionView.register(TitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header)
        collectionView.register(TitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footer)
        
        
        collectionView.backgroundColor = backColor
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arr = [ 8 , 8 ]
        return arr[section]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MineCollectionViewCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = backColor.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var kindView : UICollectionReusableView!
        if(kind == UICollectionElementKindSectionHeader){
            
            kindView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header, for:   indexPath)
            let view0 = kindView.viewWithTag(0)
            view0?.backgroundColor = UIColor.white
            
            let lab1 = kindView.viewWithTag(1) as! UILabel
            lab1.font = UIFont.systemFont(ofSize: 15)
            lab1.frame = CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH, height: 44)
            lab1.text = "lable1"
            
            
            
            
        }else if(kind == UICollectionElementKindSectionFooter){
            
            kindView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footer, for: indexPath)
            
        }
        
        
        
        
        return kindView
        
    }
    


}

class TitleView: UICollectionReusableView {
    var  nameLab :UILabel! = nil
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        nameLab = UILabel()
        nameLab.tag = 1
        self.addSubview(nameLab)
    }
    
}

