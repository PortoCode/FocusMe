//
//  CGPoint+Ext.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 08/10/25.
//

import Foundation

extension CGPoint {
    func distance(to other: CGPoint) -> CGFloat {
        let dx = other.x - x
        let dy = other.y - y
        return sqrt(dx * dx + dy * dy)
    }
}
