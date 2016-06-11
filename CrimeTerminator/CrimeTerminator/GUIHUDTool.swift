//
//  GUIHUDTool.swift
//  CrimeTerminator
//
//  Created by kenny on 5/11/16.
//  Copyright © 2016 kenny. All rights reserved.
//

import UIKit
import MBProgressHUD

class GUIHUDTool: NSObject {
    /**
     显示提示信息
     
     - parameter info: 信息
     - parameter view: 目标 View
     */
     func showMessage(info:String){
        
        let hud = MBProgressHUD.showHUDAddedTo(topMostView(), animated: true)
        hud.mode = .Text
        hud.labelText = info
        hud.hide(true ,afterDelay: 0.8)
    }
    
    /**
     获取最上层的 view
     
     - returns: 最上层的 View
     */
    func topMostView() -> UIView{
        
        var topController = UIApplication.sharedApplication().keyWindow?.rootViewController
        
        while (topController!.presentedViewController != nil) {
            topController = topController!.presentedViewController
        }
        return topController!.view
    }
}
