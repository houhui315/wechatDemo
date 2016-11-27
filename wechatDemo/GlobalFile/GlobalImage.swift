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

    internal class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    internal class func renderImageWithImageName(_ image: String) -> UIImage {
        
        return (UIImage.init(named: image)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!
    }
    
    internal class func resizeImageWithEdge(image:String, edge:UIEdgeInsets) -> UIImage {
        
        return GlobalImage.renderImageWithImageName(image).resizableImage(withCapInsets: edge)
    }
}
