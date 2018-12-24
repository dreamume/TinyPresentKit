//
//  DemosTableViewController.swift
//  TinyPresentKitExamples
//
//  Created by jcy on 2019/1/10.
//  Copyright © 2019 dreamume. All rights reserved.
//

import UIKit
import TinyPresentKit

class DemosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorInset = .zero
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(
        _ tableView: UITableView, 
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "presented from left"
        case 1:
            cell.textLabel?.text = "presented from top"
        case 2:
            cell.textLabel?.text = "presented from right"
        case 3:
            cell.textLabel?.text = "presented from bottom"
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let controller: UIViewController = UIStoryboard(
                name: "Main", 
                bundle: nil
            ).instantiateViewController(withIdentifier: "LeftViewController") as UIViewController
            let config = PresentationConfig()
            config.direction = .left
            config.presentLength = 192
            controller.presentationConfig = config
            controller.runModal();
        case 1:
            let controller: UIViewController = UIStoryboard(
                name: "Main", 
                bundle: nil
            ).instantiateViewController(withIdentifier: "TopViewController") as UIViewController
            let config = PresentationConfig()
            config.direction = .top
            config.presentLength = 340
            controller.presentationConfig = config
            controller.runModal();
        case 2:
            let controller: UIViewController = UIStoryboard(
                name: "Main", 
                bundle: nil
            ).instantiateViewController(withIdentifier: "RightViewController") as UIViewController
            let config = PresentationConfig()
            config.direction = .right
            config.presentLength = 240
            controller.presentationConfig = config
            controller.runModal();
        case 3:
            var displayData = DisplayModel<String>()
            displayData.value = "86"
            displayData.validValues = ["86", "1", "33", "44", "49"]
            displayData.displayValue = "China"
            displayData.validDisplayValues = ["China", "USA", "France", "Britain", "Germany"]
            let vc = PickerViewController<String>(displayData)
            vc.title = "Country Code"
            vc.runModal()
        default:
            break
        }

    }
}
