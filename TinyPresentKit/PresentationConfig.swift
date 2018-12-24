//
//  PresentConfig.swift
//  TinyPresentKit
//
//  Created by dreamume on 2018/12/24.
//  Copyright © 2018 dreamume. All rights reserved.
//

import Foundation
import UIKit

public enum PresentationDirection {
case left
case top
case right
case bottom
}

public class PresentationConfig {
    public static let defaultPresentationHeight: CGFloat = 300.0
    public static let defaultDuration = 0.3
    public static let defaultDelay = 0.1
    public static let defaultAlpha: CGFloat = 0.7
    public static let defaultDampingRatio: CGFloat = 0.9
    public static let defaultInitialSpringVelocity: CGFloat = 0.1
    public static let defaultAnimationOptions: UIView.AnimationOptions = []

    public static let shared = PresentationConfig()

    public var direction: PresentationDirection = .bottom
    public var duration = defaultDuration
    public var delay = defaultDelay
    public var dampingRatio = defaultDampingRatio
    public var velocity = defaultInitialSpringVelocity
    public var isClickDimmyViewTriggerDismiss = true
    public var dimmingViewAlpha = defaultAlpha
    public var presentLength: CGFloat = defaultPresentationHeight
    public var completion: ((Bool) -> Void)? = nil
    public var animationOptions: UIView.AnimationOptions = defaultAnimationOptions

    public init() {
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let config = PresentationConfig();
        config.direction = self.direction
        config.duration = self.duration
        config.delay = self.delay
        config.dampingRatio = self.dampingRatio
        config.velocity = self.velocity
        config.isClickDimmyViewTriggerDismiss = self.isClickDimmyViewTriggerDismiss
        config.dimmingViewAlpha = self.dimmingViewAlpha
        config.presentLength = self.presentLength
        config.completion = self.completion
        config.animationOptions = self.animationOptions

        return config
    }
}


private var AssociatedObjectPresentationConfig: UInt8 = 0

extension UIViewController {

    public var presentationConfig: PresentationConfig? {
        get {
            return objc_getAssociatedObject(
                self, 
                &AssociatedObjectPresentationConfig) as? PresentationConfig
        }
        set {
            objc_setAssociatedObject(
                self, 
                &AssociatedObjectPresentationConfig, 
                newValue, 
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func runModal() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UIViewController()

        window.rootViewController = controller
        window.tintColor = UIApplication.shared.delegate?.window??.tintColor

        window.makeKeyAndVisible()
        if self.presentationConfig == nil {
            self.presentationConfig = PresentationConfig.shared.copy() as? PresentationConfig
        }
        controller.presentationManager = PresentationManager()
        self.transitioningDelegate = controller.presentationManager
        self.modalPresentationStyle = .custom
        controller.present(self, animated: true, completion: nil)
    }
}

func findPresentedController() -> UIViewController? {
    for window in UIApplication.shared.windows.reversed() {
        if window.windowLevel == .normal {
            return window.rootViewController?.presentedViewController
        }
    }

    return nil
}
