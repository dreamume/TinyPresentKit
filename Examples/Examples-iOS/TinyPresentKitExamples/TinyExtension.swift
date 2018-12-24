//
//  TinyExtension.swift
//  TinyPresentKitExamples
//
//  Created by dreamume on 2019/1/10.
//  Copyright © 2019 dreamume. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    public var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.snp
        }
        return self.snp
    }
}
