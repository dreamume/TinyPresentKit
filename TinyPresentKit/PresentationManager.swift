//
//  PresentationManager.swift
//  TinyPresentKit
//
//  Created by dreamume on 2018/12/24.
//  Copyright © 2018 dreamume. All rights reserved.
//

import UIKit

class PresentationManager: NSObject {
}

// MARK: - UIViewControllerTransitionDelegate
extension PresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController, 
        presenting: UIViewController?, 
        source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = PresentationController(
            presentedViewController: presented, 
            presenting: presenting)
//        presentationController.delegate = self

        return presentationController
    }

    func animationController(
        forPresented presented: UIViewController, 
        presenting: UIViewController, 
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(isPresentation: true)
    }

    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(isPresentation: false)
    }
}

private var AssociatedObjectPresentationManager: UInt8 = 0

extension UIViewController {

    var presentationManager: PresentationManager? {
        get {
            return objc_getAssociatedObject(
                self, 
                &AssociatedObjectPresentationManager) as? PresentationManager
        }
        set {
            objc_setAssociatedObject(
                self, 
                &AssociatedObjectPresentationManager, 
                newValue, 
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
