//
//  ZGControlVC.swift
//  ZGSuctionControlDemo
//
//  Created by 赵国进 on 2017/8/1.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

import UIKit
import SnapKit

class CustomerServiceView: UIView {
    
    let kScreenH = UIScreen.main.bounds.height
    let kScreenW = UIScreen.main.bounds.width
    
    public static let shared = CustomerServiceView()
    
    fileprivate var canChangeAlpha = true
    
    let btnWidth = 50.fitScreenWidth()
    let btnHeight = 50.fitScreenHeight()
    
    fileprivate var lastX: CGFloat = 0
    fileprivate var lastY: CGFloat = 0
    
    private override init(frame: CGRect) {
        
        
        let x = UIScreen.main.bounds.width - btnWidth - 5
        let y = UIScreen.main.bounds.height / 2 + 20.fitScreenHeight()
        super.init(frame: CGRect(x: x, y: y, width: btnWidth, height: btnHeight))
        let backImageView = UIImageView()
        addSubview(backImageView)
        //        backImageView.image = UIImage(named: "111")
        backImageView.backgroundColor = UIColor.red
        
        backImageView.snp.remakeConstraints { (make) in
            make.top.right.left.bottom.equalTo(0)
        }
        lastX = center.x
        lastY = center.y
        let panRcognize = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(pan:)))
        self.addGestureRecognizer(panRcognize)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(tap:)))
        self.addGestureRecognizer(tap)
        self.alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleTapGesture(tap: UITapGestureRecognizer?){
        
        self.alpha = 1
        print("被点击")
        //点击响应事件之后需要调用changeAlpha改变透明度
    }
    
    func changeAlpha(){
        guard canChangeAlpha else {
            return
        }
        weak var weakSelf = self
        weakSelf?.canChangeAlpha = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
            UIView.animate(withDuration: 1, animations: {
                weakSelf?.alpha = 0.6
                weakSelf?.canChangeAlpha = true
            })
        })
    }
    
    func handlePanGesture(pan:UIPanGestureRecognizer){
        if pan.view == nil{
            return
        }
        switch pan.state {
            
        case .began: self.alpha = 1
            
        case .changed:
            let translation = pan.translation(in: self.superview)
            pan.view?.center = CGPoint(x: lastX + translation.x, y: lastY + translation.y)
        case .ended:
            var stopPoint = CGPoint.init(x: 0, y: kScreenH / 2)
            if (pan.view!.center.x < kScreenW / 2.0) {
                if (pan.view!.center.y <= kScreenH/2.0) {
                    //左上
                    stopPoint = pan.view!.center.x  >= pan.view!.center.y ? CGPoint(x: pan.view!.center.x,y: btnWidth/2.0) : CGPoint(x: btnWidth/2.0,y: pan.view!.center.y)
                }else{
                    //左下
                    stopPoint = pan.view!.center.x  >= kScreenH - pan.view!.center.y ? CGPoint(x: pan.view!.center.x,y: kScreenH - btnWidth/2.0) : CGPoint(x:btnWidth/2.0,y: pan.view!.center.y)
                }
            }else{
                if (pan.view!.center.y <= kScreenH/2.0) {
                    //右上
                    stopPoint = kScreenW - pan.view!.center.x  >= pan.view!.center.y ? CGPoint(x: pan.view!.center.x,y: btnWidth/2.0) : CGPoint(x: kScreenW - btnWidth/2.0,y: pan.view!.center.y)
                }else{
                    //右下
                    stopPoint = kScreenW - pan.view!.center.x  >= kScreenH - pan.view!.center.y ? CGPoint(x: pan.view!.center.x,y: kScreenH - btnWidth/2.0) : CGPoint(x: kScreenW - btnWidth/2.0,y: pan.view!.center.y)
                }
            }
            
            if (stopPoint.x - btnWidth/2.0 <= 0) {
                stopPoint = CGPoint(x: btnWidth/2.0,y: stopPoint.y)
            }
            
            if (stopPoint.x + btnWidth/2.0 >= kScreenW) {
                stopPoint = CGPoint(x: kScreenW - btnWidth/2.0,y: stopPoint.y)
            }
            
            if (stopPoint.y - btnWidth/2.0 <= 0) {
                stopPoint = CGPoint(x: stopPoint.x,y: btnWidth/2.0)
            }
            
            if (stopPoint.y + btnWidth/2.0 >= kScreenH) {
                stopPoint = CGPoint(x: stopPoint.x,y: kScreenH - btnWidth/2.0)
            }
            
            lastX = stopPoint.x
            lastY = stopPoint.y
            
            weak var weakSelf = self
            UIView.animate(withDuration: 0.3, animations: {
                pan.view!.center = stopPoint
            }, completion: { (finish) in
                weakSelf?.changeAlpha()
            })
            
        default:
            break
        }
    }
    
}

extension Int {
    
    func fitScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height - 64;
        let height : CGFloat = 667.0 - 64;
        let scale = screenHeight / height ;
        return scale * CGFloat(self);
    }
    
    func fitScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width;
        let width : CGFloat = 375;
        let scale = screenWidth / width ;
        return scale * CGFloat(self);
    }
    
}

extension CGFloat {
    
    func fitScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height - 64;
        let height : CGFloat = 667.0 - 64;
        let scale = screenHeight / height ;
        return scale * CGFloat(self);
    }
    
    func fitScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.height;
        let width : CGFloat = 375;
        let scale = screenWidth / width ;
        return scale * CGFloat(self);
    }
    
}
