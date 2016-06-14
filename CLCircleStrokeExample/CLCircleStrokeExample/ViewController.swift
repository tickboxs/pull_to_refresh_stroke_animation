    //
//  ViewController.swift
//  pullDownToExplode
//
//  Created by 蔡磊 on 16/6/12.
//  Copyright © 2016年 cailei. All rights reserved.
//

import UIKit

let appWidth = UIScreen.mainScreen().bounds.width
let appHeight = UIScreen.mainScreen().bounds.height
    
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var circleStrokeView = CLCircleStrokeView()
    
    lazy var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: appWidth, height: appHeight), style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        prepareView()
        setupUI()
        
    }

    //MARK:UI
    private func prepareView() -> Void{
        
    }
    
    private func setupUI() -> Void{
        view.addSubview(tableView)
        tableView.addSubview(circleStrokeView)
        circleStrokeView.center = CGPoint(x: appWidth*0.5, y: -25)
        circleStrokeView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    
    //MARK:tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        let progress =  scrollView.contentOffset.y/100
        if (progress <= 0.0 && progress >= -1.0){
            
            self.circleStrokeView.progress = -progress
            
            //超过阈值则执行动画
            if( progress <= -0.9){
                
                self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
                //如果有动画进行 则直接返回
                if self.circleStrokeView.isAnimating == true{
                    return
                }

                self.circleStrokeView.startRotation()
            
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    
                    self.circleStrokeView.endRotation()
                    
                    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                        scrollView.contentInset = UIEdgeInsetsZero
                        self.circleStrokeView.isAnimating = false

                        
                    }
                }
                
            }

        }
    }


}

