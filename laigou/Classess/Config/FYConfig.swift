//
//  FYConfig.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import CommonCrypto

let BASE_API_URL = "v109/"
let IS_DEBUG = true


/// 判断是否为iphonex 系列
///
/// - Returns: Bool
func isPhoneX() ->Bool {
    if #available(iOS 11.0, *) {
        if (UIApplication.shared.delegate as? SceneDelegate )?.window?.safeAreaInsets.bottom != 0 {
            return true
        }
    }
    return false
}
//屏幕宽度
var kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
var kScreenHeight = UIScreen.main.bounds.size.height
/// tabBar高度
let kTabBarHeight:CGFloat = isPhoneX() ? 83 : 49
/// nav高度
let kNavBarHeight:CGFloat = isPhoneX() ? 88 : 64
/// 底部手势框的高度
let kBottomLineHeight : CGFloat = isPhoneX() ? 34 : 0
/// 设置随机颜色
func UIColorRandom() -> UIColor {
    let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
    return color;
}

var RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

// MARK: - 颜色的设置
extension UIColor {
    
     convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
          self.init(red: CGFloat(r) / 255.0,
                    green: CGFloat(g) / 255.0,
                    blue: CGFloat(b) / 255.0,
                    alpha: a)
      }
      
      class var random: UIColor {
          return UIColor(r: arc4random_uniform(256),
                         g: arc4random_uniform(256),
                         b: arc4random_uniform(256))
      }
      
      func image() -> UIImage {
          let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
          UIGraphicsBeginImageContext(rect.size)
          let context = UIGraphicsGetCurrentContext()
          context!.setFillColor(self.cgColor)
          context!.fill(rect)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return image!
      }
      
      class func hex(hexString: String) -> UIColor {
          var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
          if cString.count < 6 { return UIColor.black }
          
          let index = cString.index(cString.endIndex, offsetBy: -6)
          let subString = cString[index...]
          if cString.hasPrefix("0X") { cString = String(subString) }
          if cString.hasPrefix("#") { cString = String(subString) }
          
          if cString.count != 6 { return UIColor.black }
          
          var range: NSRange = NSMakeRange(0, 2)
          let rString = (cString as NSString).substring(with: range)
          range.location = 2
          let gString = (cString as NSString).substring(with: range)
          range.location = 4
          let bString = (cString as NSString).substring(with: range)
          
          var r: UInt32 = 0x0
          var g: UInt32 = 0x0
          var b: UInt32 = 0x0
          
          Scanner(string: rString).scanHexInt32(&r)
          Scanner(string: gString).scanHexInt32(&g)
          Scanner(string: bString).scanHexInt32(&b)
          
          return UIColor(r: r, g: g, b: b)
      }
    
}

let mainColor = UIColor.hex(hexString: "#24B5A1")

func getCurrentController() -> UIViewController {
    
    if #available(iOS 13.0, *) {
        var currentVC = UIApplication.shared.windows.first?.rootViewController
                while (currentVC?.presentedViewController != nil) {
                  currentVC = currentVC?.presentedViewController
                }
                if (currentVC?.isKind(of: UITabBarController.self))! {
                    currentVC = (currentVC as! UITabBarController).selectedViewController
                }
                if (currentVC?.isKind(of: UINavigationController.self))! {
                    currentVC = (currentVC as! UINavigationController).visibleViewController
                }
                return currentVC!
    } else {
        var currentVC = UIApplication.shared.keyWindow?.rootViewController
                while (currentVC?.presentedViewController != nil) {
                  currentVC = currentVC?.presentedViewController
                }
                if (currentVC?.isKind(of: UITabBarController.self))! {
                    currentVC = (currentVC as! UITabBarController).selectedViewController
                }
                if (currentVC?.isKind(of: UINavigationController.self))! {
                    currentVC = (currentVC as! UINavigationController).visibleViewController
                }
                return currentVC!
    }
    
   
}

private func viewForController(view:UIView)->UIViewController?{
    var next:UIView? = view
    repeat{
        if let nextResponder = next?.next, nextResponder is UIViewController {
            return (nextResponder as! UIViewController)
        }
        next = next?.superview
    }while next != nil
    return nil
}

extension String {
    //是否是有效的电话号码
    func isValidMobileNumber() -> Bool {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9]|9[8])\\d{8}$"
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|6[6]|7[08]|8[2-478])\\d{8}$";
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56]|9[9])\\d{8}$"
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        let regextestMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestCM = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestCT = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@", PHS)
        let regextestCU = NSPredicate(format: "SELF MATCHES %@", CU)
        if (regextestMobile.evaluate(with: self) == true) ||
            regextestCM.evaluate(with: self) == true ||
            regextestCT.evaluate(with:self) == true ||
            regextestCU.evaluate(with: self) == true ||
            regextestPHS.evaluate(with: self) == true {
            return true
        }
        return false
    }
    //是否是有效的银行卡
    func isValidBankCardNumber() -> Bool {
        let BANKCARD = "^(\\d{16}|\\d{19})$";
        let predicate = NSPredicate(format: "SELF MATCHES %@", BANKCARD)
        return predicate.evaluate(with: self)
    }
    
    //是否是有效的邮箱
    func isValidEmail() -> Bool {
        let emailRegex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
}
extension String {
    var md5 : String{
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< CC_MD5_DIGEST_LENGTH{
            md5String.appendFormat("%02x", buffer[Int(i)])
        }
        free(buffer)
        return md5String as String
    }
}

public enum UIViewGradientDirection {
    case horizontally
    case vertically
}

public extension UIView {
    /// x
    var fy_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    ///y
    var fy_y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
            
        }
    }
    
    ///height
    var fy_height : CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    ///width
    var fy_width : CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    //size
    var fy_size : CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    //centerx
    var fy_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centery
    var fy_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    ///origin
    var fy_origin : CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    ///maxX
    var fy_maxX : CGFloat {
        get {
            return frame.origin.x + frame.size.width;
        }
    }
    
    ///maxY
    var fy_maxY : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
    }
    
    ///minX
    var fy_minX : CGFloat {
        get{
            return frame.minX
        }
    }
    
    ///minY
    var fy_minY : CGFloat {
        get{
            return frame.minY
        }
    }
    /// e设置指定位置的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置,上下左右
    ///   - radius: 角度
    func customRectCorner(corners: UIRectCorner,radius:CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    /// 设置指定部位的圆角
    @discardableResult
    func fy_borderSpecified(_ specified: UIRectCorner,cornerRadius:CGFloat) -> UIView {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: specified, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
    //view的渐变色
    func fy_addGradientLayer(gradientColors: [UIColor],gradientDirection direction: UIViewGradientDirection, gradientFrame: CGRect? = nil) {
        
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //设置frame和插入view的layer
        if let gradientFrame = gradientFrame {
            gradientLayer.frame = gradientFrame
        }else {
            gradientLayer.frame = CGRect(x: 0, y: 0, width: fy_width, height: fy_height)
        }
        
        gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
            return color.cgColor
        })
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        if direction == .horizontally {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImage {
    //根据颜色创建一个纯Image
   
}

extension String {
    /// 计算字符串高度,已知宽度
    ///
    /// - Parameters:
    ///   - font: 字符号
    ///   - width: 宽度
    /// - Returns: 高度
    func calculateHeight(_ font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: 99999)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    /// 计算字符串宽度,已知高度
    ///
    /// - Parameters:
    ///   - font: 字号
    ///   - height: 高度
    /// - Returns: 宽度
    func calculateWidth(_ font: UIFont, height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: 99999, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    /// string转cgfloat
    ///
    /// - Returns: 转成功的float类型
    func toCGFloat() -> CGFloat {
        var cgFloat : CGFloat = 0
        if let doubleValue = Double(self) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}



class FYConfig: NSObject {
    
   

}
