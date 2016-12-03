//
//  RYLocalizer.swift
//  RYLocalizer
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import Foundation

fileprivate let kLanguageDictionary = [
    "en":"English",
    "cs":"Český",
    "de":"Deutsch",
    "ru":"Русский",
    "uk":"Українська"
]

fileprivate let kLanguageCodeDefault = "uk"
fileprivate let kLanguageChange = "localLanguageChange"

class RYLocalizer {
    
    static let shared = RYLocalizer()
    
    fileprivate let codeLength = kLanguageCodeDefault.characters.count
    fileprivate var localizidBundle: Bundle?
    
    var languageTitle: String {
        get {
            return kLanguageDictionary[self.languageCode]!
        }
    }
    
    //MARK: - Init
    fileprivate init() {
        
        let deviceLangCode = Locale.preferredLanguages[0].first(charsCount: self.codeLength)
        self.languageCode = kLanguageDictionary.keys.contains(deviceLangCode) ? deviceLangCode : kLanguageCodeDefault
        self.localizidBundle = Bundle(path: Bundle.main.path(forResource: self.languageCode, ofType: "lproj")!)
    }
    
    //MARK: Setup language
    var languageCode: String {
        didSet {
            if languageCode.characters.count >= self.codeLength {
                let langCode = languageCode.first(charsCount: self.codeLength)
                
                if kLanguageDictionary.keys.contains(langCode) {
                    languageCode = langCode
                    self.localizidBundle = Bundle(path: Bundle.main.path(forResource: self.languageCode, ofType: "lproj")!)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLanguageChange), object: nil)
                } else {
                    languageCode = oldValue
                }
            } else {
                languageCode = oldValue
            }
        }
    }
    
    func setupLanguageByTitle(_ langTitle: String) -> Bool {
        
        if kLanguageDictionary.values.contains(langTitle) {
            let allKeys = allKeysForValue(kLanguageDictionary, val:langTitle)
            if allKeys.count == 1 {
                self.languageCode = allKeys[0]
                return true
            }
        }
        return false
    }
    
    //MARK: Localization
    func local(_ strKey:String)->String {
        return (self.localizidBundle?.localizedString(forKey: strKey, value: strKey, table: nil))!
    }

    //MARK: List
    func languagesListTitle () -> [String] {
        return Array(kLanguageDictionary.values)
    }
    
    func languagesListCode () -> [String] {
        return Array(kLanguageDictionary.keys)
    }
    
    //MARK: - Helpers
    fileprivate func allKeysForValue<K, V : Equatable>(_ dict: [K : V], val: V) -> [K] {
        return dict.filter{ $0.1 == val }.map{ $0.0 }
    }
}
