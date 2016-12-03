//
//  RYSettingsTableViewController.swift
//  RYLocalizer
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import UIKit

fileprivate let kTitle = "Language"

class RYSettingsTableViewController: UITableViewController {
    
    var localizer: RYLocalizer? {
        didSet {
            self.languageTitles = (localizer?.languagesListTitle())!
        }
    }
    
    static func storyboardInstance() -> RYSettingsTableViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier:String(describing: self)) as? RYSettingsTableViewController
    }
    
    fileprivate var languageTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.localizer?.local(kTitle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let languageTitle = languageTitles[indexPath.row]
        cell.textLabel?.text = languageTitle
        cell.accessoryType = (languageTitle == self.localizer?.languageTitle) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTitle = self.languageTitles[indexPath.row]
        if selectedTitle != self.localizer?.languageTitle {
            if (self.localizer?.setupLanguageByTitle(selectedTitle))! {
                self.title = self.localizer?.local(kTitle)
                self.tableView.reloadData()
            }
        }
    }
}
