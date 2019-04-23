//
//  BSUIViewAdaptScreenExtensions.swift
//  CashLoan_iOS
//
//  Created by lbs on 2019/4/13.
//  Copyright © 2019 SHUABAO. All rights reserved.
//

import Foundation
import UIKit

public func BSAdaptW(_ floatValue: CGFloat) -> CGFloat {
    return BSAdaptScreenConfig.service.adaptBlock?(floatValue) ?? floatValue
}

class BSAdaptScreenConfig {
    typealias BSAdaptScreenBlock = (CGFloat)->(CGFloat)
    
    private(set) var adaptBlock: BSAdaptScreenBlock?
    static let service = BSAdaptScreenConfig()

    static func config(_ handle: BSAdaptScreenBlock?) {
        BSAdaptScreenConfig.service.adaptBlock = handle
    }
    
}

public struct AdaptScreenType: OptionSet {
    
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// 对约束的constant等比例
    public static let constraint = AdaptScreenType(rawValue: 1)
    /// 对字体等比例
    public static let fontSize = AdaptScreenType(rawValue: 2)
    /// 对圆角等比例
    public static let cornerRadius = AdaptScreenType(rawValue: 4)
    /// 对现有支持的属性等比例
    public static let all: AdaptScreenType = [constraint, fontSize, cornerRadius]
}



public extension UIView {
    
    /// 遍历当前view对象的subviews，对目标进行等比例换算
    ///
    /// - Parameters:
    ///   - type: 想要和基准屏幕等比例换算的属性类型
    ///   - recursion: 是否需要递归对子view进行操作
    ///   - recursionExceptViews: 递归时需要例外的viewclass
    func adaptScreenWidth(type: AdaptScreenType, recursion: Bool = true, recursionExceptViews: [AnyClass]? = nil) {
        if self.isExceptViewClassWithClassArray(recursionExceptViews) {
            return
        }
        
        // 约束
        if type.contains(.constraint) {
            for subConstraint in self.constraints {
                subConstraint.constant = BSAdaptW(subConstraint.constant)
            }
        }
        
        // 字体大小
        if type.contains(.fontSize) {
            
            if let labelSelf = self as? UILabel, !labelSelf.isKind(of: NSClassFromString("UIButtonLabel")!) {
                labelSelf.font = labelSelf.font.withSize(BSAdaptW(labelSelf.font.pointSize))
            } else if let textFieldSelf = self as? UITextField {
                textFieldSelf.font = textFieldSelf.font!.withSize(BSAdaptW(textFieldSelf.font!.pointSize))
            } else if let buttonSelf = self as? UIButton {
                buttonSelf.titleLabel!.font = buttonSelf.titleLabel!.font.withSize(BSAdaptW(buttonSelf.titleLabel!.font.pointSize))
            } else if let textViewSelf = self as? UITextView {
                textViewSelf.font = textViewSelf.font!.withSize(BSAdaptW(textViewSelf.font!.pointSize))
            }
        }
        
        // 圆角
        if type.contains(.cornerRadius), self.layer.cornerRadius != 0 {
            self.layer.cornerRadius = BSAdaptW(self.layer.cornerRadius)
        }
        
        if recursion {
        // 继续对子view操作
            for subView in self.subviews {
                subView.adaptScreenWidth(type: type, recursion: recursion, recursionExceptViews: recursionExceptViews)
            }
        }

    }
    
    
    /// 当前view对象是否是例外的视图
    func isExceptViewClassWithClassArray(_ classArray: [AnyClass]?) -> Bool {
        var isExcept = false
        if let classArray = classArray {
            for item in classArray {
                if self.isKind(of: item.class()) {
                    isExcept = true
                }
            }
        }        
        return isExcept
    }
}

