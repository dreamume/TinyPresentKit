//
//  PresentationAnimator.swift
//  TinyPresentKit
//
//  Created by dreamume on 2018/12/24.
//  Copyright © 2018 dreamume. All rights reserved.
//

import UIKit

/// Present and dismiss animator object
class PresentationAnimator: NSObject {

    let isPresentation: Bool

    init(isPresentation: Bool) {
        self.isPresentation = isPresentation

        super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension PresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : 
        UITransitionContextViewControllerKey.from
        guard let config = transitionContext?.viewController(forKey: key)?.presentationConfig else { 
            return 0.0
        }

        return config.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : 
        UITransitionContextViewControllerKey.from

        guard let controller = transitionContext.viewController(forKey: key) else { 
            return
        }
        guard let config = controller.presentationConfig else { 
            return 
        }

        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }

        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch config.direction {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }

        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame

        controller.view.frame = initialFrame
        UIView.animate(withDuration: config.duration, 
            delay: config.delay, 
            usingSpringWithDamping: config.dampingRatio, 
            initialSpringVelocity: config.velocity,
            options: config.animationOptions,
            animations: {
                controller.view.frame = finalFrame
            }) { finished in
            config.completion?(finished)
            transitionContext.completeTransition(finished)
        }
    }
}
