//
//  GlobalImage.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

//图片处理相关

class GlobalImage: NSObject {

    internal class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    internal class func renderImageWithImageName(image: String) -> UIImage {
        
        return (UIImage.init(named: image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))!
    }
    
    internal class func resizeImageWithEdge(image image:String, edge:UIEdgeInsets) -> UIImage {
        
        return GlobalImage.renderImageWithImageName(image).resizableImageWithCapInsets(edge)
    }
}
