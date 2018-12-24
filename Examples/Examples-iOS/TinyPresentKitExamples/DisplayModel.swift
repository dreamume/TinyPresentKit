//
//  DisplayModel.swift
//  Wallet
//
//  Created by jcy on 2018/5/30.
//  Copyright © 2018年 7owen. All rights reserved.
//

import Foundation

struct SimpleDisplayModel<T> {
    var name = ""
    var value: T
}

struct DisplayModel<T> {
    var value: T?
    var displayValue: String?
    var validValues: [T]?
    var validDisplayValues: [String]?
    var unit: String?
    var displayUnit: String?
}
