//
//  PickerViewController.swift
//  TinyPresentKitExamples
//
//  Created by dreamume on 2019/1/4.
//  Copyright © 2019年 dreamume. All rights reserved.
//

import UIKit
import SnapKit
import TinyPresentKit

class PickerViewController<T>: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate 
where T : Equatable {

    var dataSource: DisplayModel<T>
    var completion: ((T) -> ())?

    init(_ data: DisplayModel<T>) {
        dataSource = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupConstraints() {
        self.view.backgroundColor = UIColor.init(
            red: 0.9608, 
            green: 0.9647, 
            blue: 0.9804, 
            alpha: 1.0)

        let toolBar = UIToolbar(
            frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: 44))
        toolBar.barStyle = .black
        self.view.addSubview(toolBar)

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancelAction))
        cancelButton.tintColor = UIColor.white

        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)

        let label = UILabel()
        label.text = self.title
        label.textColor = UIColor.white
        let titleItem = UIBarButtonItem(customView: label)

        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)

        let confirmButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: self,
            action: #selector(confirmAction))
        confirmButton.tintColor = UIColor.green

        toolBar.items = [cancelButton, space1, titleItem, space2, confirmButton]
        toolBar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeArea.top)
            make.left.equalTo(self.view.safeArea.left)
            make.right.equalTo(self.view.safeArea.right)
            make.height.equalTo(44)
        }

        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate   = self
        self.view.addSubview(picker)
        picker.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toolBar.snp.bottom)
            make.left.equalTo(self.view.safeArea.left)
            make.right.equalTo(self.view.safeArea.right)
            if let len = self.presentationConfig?.presentLength {
                make.height.equalTo(len - 44)
            }
        }

        if let value = self.dataSource.value, 
        let index = self.dataSource.validValues?.index(of: value) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
    }

    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func confirmAction() {
        self.dismiss(animated: true, completion: {
                if let displayValue = self.dataSource.displayValue, 
                let index = self.dataSource.validDisplayValues?.index(of: displayValue), 
                let value = self.dataSource.validValues?[index], 
                let oldValue = self.dataSource.value, 
                value != oldValue {
                    self.completion?(value)
                }
            })
    }

    // Mark - UIPickerViewDataSource & UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.validValues?.count ?? 0
    }

    func pickerView(
        _ pickerView: UIPickerView, 
        titleForRow row: Int, 
        forComponent component: Int
    ) -> String? {
        return self.dataSource.validDisplayValues?[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dataSource.displayValue = self.dataSource.validDisplayValues?[row]
    }
}
