//
//  UIView+Extension.swift
//  TextfieldWithSlideDownNote_build
//
//  Created by Hiển Huỳnh on 02/08/2022.
//

import UIKit

extension UIView {

    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}
