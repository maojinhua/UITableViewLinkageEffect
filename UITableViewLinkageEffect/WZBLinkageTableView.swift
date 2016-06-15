//
//  WZBLinkageTableView.swift
//  UITableViewLinkageEffect
//
//  Created by Mao hua on 16/6/15.
//  Copyright © 2016年 Mao hua. All rights reserved.
//

import Foundation
import UIKit

//let WZBScreenHeight = UIScreen.mainScreen().bounds.size.height;
//let WZBScreenWidth = UIScreen.mainScreen().bounds.size.width;
class WZBLinkageTableView: UIViewController,UITableViewDelegate,UITableViewDataSource {
  //因为Swift中要求变量或常量在声明时就要初始化其值，所以我们在实际开发中，声明变量或常量时使用可选类型。
    var leftTableView:UITableView?;
    var rightTableView:UITableView?;
    var datas:NSMutableArray? = ["快餐","电影","聚会","出游","健身","旅游","运动","美食"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    func setBaseTableView()
    {
        //let datasArr:Array = [];
        //datas?.addObjectsFromArray(datasArr);
        //添加左边的Tableview
        let leftTableView = UITableView(frame: CGRectMake(0, 0, WZBScreenWidth * 0.25, WZBScreenHeight))
        leftTableView.backgroundColor = UIColor.redColor();
        self.view.addSubview(leftTableView);
        self.leftTableView = leftTableView;
        //添加右边的TableView
        let rightTableView = UITableView(frame: CGRectMake(WZBScreenWidth * 0.25, 0, WZBScreenWidth * 0.75, WZBScreenHeight))
        rightTableView.backgroundColor = UIColor.redColor();
        self.view.addSubview(rightTableView);
        self.rightTableView = rightTableView;
        
        //设置delegate和dataSource
        rightTableView.dataSource=self;
        rightTableView.delegate = self;
        
        leftTableView.dataSource=self;
        leftTableView.delegate = self;
        //默认选择左边tableView的第一行
        let index = NSIndexPath(forRow: 0, inSection: 0)
        leftTableView.selectRowAtIndexPath(index, animated: true, scrollPosition: UITableViewScrollPosition.Top);
        
    }
    
    //scrollView结束滚动的时候调用的方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.selectLeftTableViewWthScrollView(scrollView)
    }
    func selectLeftTableViewWthScrollView(scrollView:UIScrollView)
    {
        // 如果现在滑动的是左边的tableView，不做任何处理
        if(scrollView == self.leftTableView)
        {return;}
        // 滚动右边tableView，设置选中左边的tableView某一行。indexPathsForVisibleRows属性返回屏幕上可见的cell的indexPath数组，利用这个属性就可以找到目前所在的分区
        let path = NSIndexPath(forRow: (self.rightTableView!.indexPathsForVisibleRows?.first?.section)!, inSection: 0);
        self.leftTableView!.selectRowAtIndexPath(path, animated: true, scrollPosition: UITableViewScrollPosition.Middle);
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView==self.leftTableView {
            return 1
        }
        
            return self.datas!.count;
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==self.leftTableView {
            return self.datas!.count;
        }
       
            return 5;
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView==self.leftTableView)
        {
            return nil;
        }
        else
        {
            return self.datas![section] as? String;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "cellId";
        //创建可以循环创建的Cell的方法：tableView.dequeueReusableCellWithIdentifier(ID)!;
        //通过样式创建Cell的方法：UITableViewCell(style: .Default, reuseIdentifier: "cellId");
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(ID)!;
        if(tableView == self.leftTableView)
        {
            cell.textLabel?.text = self.datas![indexPath.row] as? String;
        }
        else
        {
            cell.textLabel?.text = "\(self.datas![indexPath.section] as! String)---第\(indexPath.row+1)行";
        }
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView==self.rightTableView)
        {// 如果点击的是右边的tableView，不做任何处理
            return;
        }
        else{// 点击左边的tableView，设置选中右边的tableView某一行。左边的tableView的每一行对应右边tableView的每个分区
            let path:NSIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.row);
            self.rightTableView!.selectRowAtIndexPath(path, animated: true, scrollPosition: .Bottom);
        }
    }
    func  tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(tableView==self.leftTableView)
        {
            return 0;
        }
        return 30;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40;
    }
    // 注释scrollViewDidScroll方法，放开下边两个方法，可以在点击leftTableView的时候去除阴影
    /*func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.selectLeftTableViewWthScrollView(scrollView);
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
     // 推拽将要结束的时候手动调一下这个方法

        self.scrollViewDidEndDecelerating(scrollView)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

