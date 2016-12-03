//
//  RYExampleTableViewController.swift
//  RYLocalizer
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import UIKit

fileprivate enum RYIndexRow: Int {
    case example = 0
    case langaugeApp = 1
    case langaugeSystem = 2
    static var count: Int { return RYIndexRow.langaugeSystem.hashValue + 1}
}

class RYExampleTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.tableView.tableFooterView = UIView()
        
        self.tableView.isUserInteractionEnabled = false
        self.tableView.isScrollEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateVC() {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RYIndexRow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
        case RYIndexRow.example.rawValue:
            cell.textLabel?.text = "Translation of the word 'Game'"
            cell.detailTextLabel?.text = "Game".localized()
            
        case RYIndexRow.langaugeApp.rawValue:
            cell.textLabel?.text = "App language"
            cell.detailTextLabel?.text = "\(RYLocalizer.shared.languageTitle) (\(RYLocalizer.shared.languageCode))"
        
        case RYIndexRow.langaugeSystem.rawValue:
            cell.textLabel?.text = "System language"
            cell.detailTextLabel?.text = self.languageSystem()
        
        default:
            break
        }
        return cell
    }

    fileprivate func languageSystem() -> String {
        let deviceLangCode = Locale.preferredLanguages[0]
        let deviceLangTitle = Locale.current.localizedString(forLanguageCode: deviceLangCode)
        
        return "\(deviceLangTitle!) (\(deviceLangCode))"
    }
}
