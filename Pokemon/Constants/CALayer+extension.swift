//
//  CALayer+extension.swift
//  Pokemon
//
//  Created by Deonte on 10/20/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor,
        alpha: Float ,
        x: CGFloat ,
        y: CGFloat ,
        blur: CGFloat ,
        spread: CGFloat)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

