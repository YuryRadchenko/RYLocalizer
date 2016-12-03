//
//  RYMainViewController.swift
//  RYLocalizer
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import UIKit

fileprivate let kLanguageChange = "localLanguageChange"

class RYMainViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!     
    fileprivate let localizer = RYLocalizer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.localizeVC),
                                               name: NSNotification.Name(rawValue: kLanguageChange),
                                               object: nil)
        
        self.localizeVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func localizeVC() {

        self.title = self.localizer.local("Localizer")
        self.settingsButton.setTitle(self.localizer.local("Settings"), for: .normal)
        
        if let exampleTableViewController = self.childViewControllers.last as? RYExampleTableViewController {
            exampleTableViewController.updateVC()
        }
    }

    @IBAction func settingsButtonTap(_ sender: UIButton) {
        
        let settingsVC = RYSettingsTableViewController.storyboardInstance()
        settingsVC?.localizer = self.localizer
        self.navigationController?.pushViewController(settingsVC!, animated: true)
    }
}
