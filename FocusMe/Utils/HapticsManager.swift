//
//  HapticsManager.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 17/09/25.
//

import UIKit

struct HapticsManager {
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
