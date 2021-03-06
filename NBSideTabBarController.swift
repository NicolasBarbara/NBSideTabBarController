//
//  NBSideTabBarController.swift
//  SideTabBar
//
//  Created by Nicolas Barbara on 7/25/18.
//  Copyright © 2018 Nicolas Barbara. All rights reserved.
//

import Foundation
import UIKit
class NBSideTabBarController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    var tableViewCells:[NBSideTableViewCell]
    var views:[NBView]
    var colorList:[UIColor]?
    var leftTableViewWidth:CGFloat
    var tableViewAnchor:NBSideTabBarAnchor
    init(dataSource:[NBSideTabBarControllerDataSource],width:CGFloat,anchor:NBSideTabBarAnchor,colors:[UIColor]?){
        self.colorList = colors
        self.tableViewAnchor = anchor
        self.leftTableViewWidth = width
        self.tableViewCells = dataSource.map({ (i) -> NBSideTableViewCell in
            return i.tableViewCell
        })
        self.views = dataSource.map({ (i) -> NBView in
            return i.view
        })
        super.init(nibName: nil, bundle: nil)
        views.forEach { (i) in
            i.sideTabBarController = self
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var selectorView = UIView()
    var leftTableViewBackgroundView = UIView()
    lazy var tableView:UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.isScrollEnabled = false
        t.backgroundColor = .clear
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    lazy var scrollView1:UIScrollView = {
        let s = UIScrollView()
        s.delegate = self
        s.backgroundColor = .white
        s.isPagingEnabled = true
        s.bounces = false
        s.translatesAutoresizingMaskIntoConstraints = false
        s.canCancelContentTouches = true
        return s
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        leftTableViewBackgroundView.backgroundColor = UIColor.gray
        leftTableViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.backgroundColor = .red
        if self.colorList != nil{
            if self.colorList?.count != 0{
                selectorView.backgroundColor = self.colorList![0]
            }
        }
        setupTableViews()
        for i in 0...self.views.count-1{
            self.scrollView1.addSubview(views[i])
            if i == 0{
                views[i].topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                views[i].bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                views[i].widthAnchor.constraint(equalToConstant: self.view.frame.width-self.leftTableViewWidth).isActive = true
                
                views[i].leftAnchor.constraint(equalTo: self.scrollView1.leftAnchor).isActive = true
                
            }
            else if i == self.views.count-1{
                views[i].topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                views[i].bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                views[i].widthAnchor.constraint(equalToConstant: self.view.frame.width-self.leftTableViewWidth).isActive = true
                views[i].leftAnchor.constraint(equalTo: views[i-1].rightAnchor).isActive = true
                
            }
            else{
                views[i].topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                views[i].bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                views[i].widthAnchor.constraint(equalToConstant: self.view.frame.width-self.leftTableViewWidth).isActive = true
                views[i].leftAnchor.constraint(equalTo: views[i-1].rightAnchor).isActive = true
            }
            scrollView1.contentSize.width = (self.view.frame.width-self.leftTableViewWidth)*CGFloat(self.views.count)
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCells[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/CGFloat(tableViewCells.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //scrollView1.scrollToItem(at: indexPath, at: .left, animated: true)
        let x = self.scrollView1.frame.width*CGFloat(indexPath.row)
        let p = CGPoint(x: x, y: 0)
        scrollView1.setContentOffset(p, animated: true)
        
    }
    func setupTableViews(){
        view.addSubview(leftTableViewBackgroundView)
        view.addSubview(selectorView)
        view.addSubview(scrollView1)
        view.addSubview(tableView)
        
        if self.tableViewAnchor == .left{
            selectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            selectorView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            selectorView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            selectorView.heightAnchor.constraint(equalToConstant: view.frame.height/CGFloat(tableViewCells.count)).isActive = true
            
            leftTableViewBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            leftTableViewBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            leftTableViewBackgroundView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            leftTableViewBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            scrollView1.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            scrollView1.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            scrollView1.leftAnchor.constraint(equalTo: self.tableView.rightAnchor).isActive = true
            scrollView1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
        else{
            selectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            selectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            selectorView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            selectorView.heightAnchor.constraint(equalToConstant: view.frame.height/CGFloat(tableViewCells.count)).isActive = true
            
            leftTableViewBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            leftTableViewBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            leftTableViewBackgroundView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            leftTableViewBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            scrollView1.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            scrollView1.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            scrollView1.rightAnchor.constraint(equalTo: self.tableView.leftAnchor).isActive = true
            scrollView1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView1{
            selectorView.frame.origin.y = scrollView.contentOffset.x / scrollView.contentSize.width * tableView.frame.height
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == scrollView1{
            if let cl = self.colorList{
                let index = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(cl.count))
                if cl.count > index{
                    selectorView.backgroundColor = cl[index]
                }
            }
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == scrollView1{
            if let cl = self.colorList{
                let index = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(cl.count))
                if cl.count > index{
                    selectorView.backgroundColor = cl[index]
                }
            }
        }
    }
}
enum NBSideTabBarAnchor{
    case left
    case right
}
struct NBSideTabBarControllerDataSource {
    let tableViewCell:NBSideTableViewCell
    let view:NBView
}
class NBView:UIView{
    var sideTabBarController:NBSideTabBarController!
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}
class NBSideCollectionViewCell:UICollectionViewCell{
    var view:NBView!{
        didSet{
            addSubview(view)
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
}
class NBSideTableViewCell:UITableViewCell{
    let label:UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let imageView1:UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFit
        return i
    }()
    init(text:String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        selectionStyle = .none
        backgroundColor = .clear
        label.text = text
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    init(image:UIImage) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        selectionStyle = .none
        backgroundColor = .clear
        imageView1.image = image
        addSubview(imageView1)
        imageView1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView1.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView1.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        selectionStyle = .none
        backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/*class NBSideTabBarController:UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    var tableViewCells:[NBSideTableViewCell]
    var views:[NBView]
    var colorList:[UIColor]?
    var leftTableViewWidth:CGFloat
    var tableViewAnchor:NBSideTabBarAnchor
    init(dataSource:[NBSideTabBarControllerDataSource],width:CGFloat,anchor:NBSideTabBarAnchor,colors:[UIColor]?){
        self.colorList = colors
        self.tableViewAnchor = anchor
        self.leftTableViewWidth = width
        self.tableViewCells = dataSource.map({ (i) -> NBSideTableViewCell in
            return i.tableViewCell
        })
        self.views = dataSource.map({ (i) -> NBView in
            return i.view
        })
        super.init(nibName: nil, bundle: nil)
        views.forEach { (i) in
            i.sideTabBarController = self
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var selectorView = UIView()
    var leftTableViewBackgroundView = UIView()
    lazy var tableView:UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.isScrollEnabled = false
        t.backgroundColor = .clear
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = .white
        c.isPagingEnabled = true
        c.bounces = false
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(NBSideCollectionViewCell.self, forCellWithReuseIdentifier: "ID")
        return c
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        leftTableViewBackgroundView.backgroundColor = UIColor.gray
        leftTableViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.backgroundColor = .red
        if self.colorList != nil{
            if self.colorList?.count != 0{
                selectorView.backgroundColor = self.colorList![0]
            }
        }
        setupTableViews()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCells[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/CGFloat(tableViewCells.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    func setupTableViews(){
        view.addSubview(leftTableViewBackgroundView)
        view.addSubview(selectorView)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        if self.tableViewAnchor == .left{
            selectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            selectorView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            selectorView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            selectorView.heightAnchor.constraint(equalToConstant: view.frame.height/CGFloat(tableViewCells.count)).isActive = true
            
            leftTableViewBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            leftTableViewBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            leftTableViewBackgroundView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            leftTableViewBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            collectionView.leftAnchor.constraint(equalTo: self.tableView.rightAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
        else{
            selectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            selectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            selectorView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            selectorView.heightAnchor.constraint(equalToConstant: view.frame.height/CGFloat(tableViewCells.count)).isActive = true
            
            leftTableViewBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            leftTableViewBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            leftTableViewBackgroundView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            leftTableViewBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: self.leftTableViewWidth).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: self.tableView.leftAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as!
        NBSideCollectionViewCell
        cell.view = views[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView{
            selectorView.frame.origin.y = scrollView.contentOffset.x / scrollView.contentSize.width * tableView.frame.height
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView{
            if let cl = self.colorList{
                let index = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(cl.count))
                if cl.count > index{
                    selectorView.backgroundColor = cl[index]
                }
            }
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == collectionView{
            if let cl = self.colorList{
                let index = Int(scrollView.contentOffset.x / scrollView.contentSize.width * CGFloat(cl.count))
                if cl.count > index{
                    selectorView.backgroundColor = cl[index]
                }
            }
        }
    }
}
 */


