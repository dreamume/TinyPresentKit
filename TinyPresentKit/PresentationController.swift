//
//  PresentationController.swift
//  TinyPresentKit
//
//  Created by dreamume on 2018/12/24.
//  Copyright © 2018 dreamume. All rights reserved.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {

    lazy var dimmingView: UIView = {
        let theView = UIView(frame: presentingViewController.view.bounds)

        var visualEffectView = 
        UIVisualEffectView(effect: UIBlurEffect(style: .dark)) as UIVisualEffectView
        visualEffectView.frame = theView.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        theView.addSubview(visualEffectView)

        let tapRecognizer = 
        UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(tapRecognizer:)))
        theView.addGestureRecognizer(tapRecognizer)

        return theView
    } ()

    @objc func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
        if let isTriggerDismiss = self.presentedViewController.presentationConfig?.isClickDimmyViewTriggerDismiss, 
        isTriggerDismiss {
            if let vc = self.presentedViewController as? CustomPresentedViewControllerDismissProtocol {
                self.presentingViewController.dismiss(animated: true, completion: {
                        vc.dismissAction()
                    })
            } else {
                self.presentingViewController.dismiss(animated: true, completion: nil)
            }
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {

        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
            withParentContainerSize: containerView!.bounds.size)

        guard let config = presentedViewController.presentationConfig else { 
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }

        switch config.direction {
        case .left:
            frame.size.width = config.presentLength
        case .right:
            frame.origin.x = containerView!.frame.width - config.presentLength > 0 ? 
            containerView!.frame.width - config.presentLength : 0
        case .top:
            frame.size.height = config.presentLength
        case .bottom:
            frame.origin.y = containerView!.frame.height - config.presentLength > 0 ? 
            containerView!.frame.height - config.presentLength : 0
        }

        return frame
    }

    /// add dimmingView to the container and let alpha animate to 1
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView
        let presentedViewController = self.presentedViewController

        self.dimmingView.frame = (containerView?.bounds)!
        if let _ = findPresentedController() {
            self.dimmingView.alpha = presentedViewController.presentationConfig!.dimmingViewAlpha

            containerView?.insertSubview(self.dimmingView, at: 0)
        } else {
            self.dimmingView.alpha = 0.0

            containerView?.insertSubview(self.dimmingView, at: 0)
            presentedViewController.transitionCoordinator?.animate(
                alongsideTransition: { (coordinatorContext) -> Void in
                    self.dimmingView.alpha = presentedViewController.presentationConfig!.dimmingViewAlpha
                }, 
                completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { (coordinatorContext) -> Void in
                self.dimmingView.alpha = 0.0
            },
            completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func size(
        forChildContentContainer container: UIContentContainer, 
        withParentContainerSize parentSize: CGSize
    ) -> CGSize {
        guard let direction = presentedViewController.presentationConfig?.direction else {
            return CGSize(width: 0, height: 0) 
        }

        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height)
        }
    }
}

protocol CustomPresentedViewControllerDismissProtocol: class {
    func dismissAction()
}
