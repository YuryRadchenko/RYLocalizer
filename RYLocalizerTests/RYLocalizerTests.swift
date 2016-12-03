//
//  RYLocalizerTests.swift
//  RYLocalizerTests
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import XCTest
@testable import RYLocalizer


class RYLocalizerTests: XCTestCase {
    
    let kEnglishTitle = "English"
    let kEnglishCode = "en"
    let kCzechTitle = "Český"
    let kCzechCode = "cs"
    let kGermanTitle = "Deutsch"
    let kGermanCode = "de"
    let kRussianTitle = "Русский"
    let kRussianCode = "ru"
    let kUkrainianTitle = "Українська"
    let kUkrainianCode = "uk"
    
    let kLanguageCodeDefault = "uk"
    
    let kLanguageCount = 5
    
    var localizer: RYLocalizer?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.localizer = RYLocalizer.shared
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testA_LanguageCodeDefault() {
        
        //Warning! Test right if simulator in Spanish example
        //Run test separately from the others
        
        let deviceLangCode = Locale.preferredLanguages[0].first(charsCount: 2)
        var result = false
        
        let langCodeArray = [kUkrainianCode, kEnglishCode, kCzechCode, kGermanCode, kRussianCode]
        if langCodeArray.count == kLanguageCount {
            print("langCodeArray.count = \(langCodeArray.count)")
            if langCodeArray.contains(deviceLangCode) {
                result = self.localizer?.languageCode == deviceLangCode
            } else {
                result = self.localizer?.languageCode == kLanguageCodeDefault
            }
            
        }
        XCTAssertTrue(result)
    }
    
    func testB1_LocalizerSetupByCode() {
        
        self.localizer?.languageCode = kEnglishCode
        var resultTitle = self.localizer?.languageTitle == kEnglishTitle
        var resultCode = self.localizer?.languageCode == kEnglishCode
        XCTAssertTrue(resultTitle && resultCode)
        
        self.localizer?.languageCode = kCzechCode
        resultTitle = self.localizer?.languageTitle == kCzechTitle
        resultCode = self.localizer?.languageCode == kCzechCode
        XCTAssertTrue(resultTitle && resultCode)
        
        self.localizer?.languageCode = kGermanCode
        resultTitle = self.localizer?.languageTitle == kGermanTitle
        resultCode = self.localizer?.languageCode == kGermanCode
        XCTAssertTrue(resultTitle && resultCode)
        
        self.localizer?.languageCode = kRussianCode
        resultTitle = self.localizer?.languageTitle == kRussianTitle
        resultCode = self.localizer?.languageCode == kRussianCode
        XCTAssertTrue(resultTitle && resultCode)
        
        self.localizer?.languageCode = kUkrainianCode
        resultTitle = self.localizer?.languageTitle == kUkrainianTitle
        resultCode = self.localizer?.languageCode == kUkrainianCode
        XCTAssertTrue(resultTitle && resultCode)
    }
    
    func testB2_LocalizerSetupByTitle() {
        
        var resultSetup = self.localizer?.setupLanguageByTitle(kEnglishTitle)
        var resultTitle = self.localizer?.languageTitle == kEnglishTitle
        var resultCode = self.localizer?.languageCode == kEnglishCode
        XCTAssertTrue(resultTitle && resultCode && resultSetup!)
        
        resultSetup = self.localizer?.setupLanguageByTitle(kCzechTitle)
        resultTitle = self.localizer?.languageTitle == kCzechTitle
        resultCode = self.localizer?.languageCode == kCzechCode
        XCTAssertTrue(resultTitle && resultCode && resultSetup!)
        
        resultSetup = self.localizer?.setupLanguageByTitle(kGermanTitle)
        resultTitle = self.localizer?.languageTitle == kGermanTitle
        resultCode = self.localizer?.languageCode == kGermanCode
        XCTAssertTrue(resultTitle && resultCode && resultSetup!)
        
        resultSetup = self.localizer?.setupLanguageByTitle(kRussianTitle)
        resultTitle = self.localizer?.languageTitle == kRussianTitle
        resultCode = self.localizer?.languageCode == kRussianCode
        XCTAssertTrue(resultTitle && resultCode && resultSetup!)
        
        resultSetup = self.localizer?.setupLanguageByTitle(kUkrainianTitle)
        resultTitle = self.localizer?.languageTitle == kUkrainianTitle
        resultCode = self.localizer?.languageCode == kUkrainianCode
        XCTAssertTrue(resultTitle && resultCode && resultSetup!)
    }
    
    func testC1_SetupIncorrectCode() {
        
        self.localizer?.languageCode = kGermanCode
        
        self.localizer?.languageCode = "a"
        XCTAssertTrue(self.localizer?.languageCode == kGermanCode)
        
        self.localizer?.languageCode = ""
        XCTAssertTrue(self.localizer?.languageCode == kGermanCode)
    }
    
    func testC2_SetupIncorrectTitle() {
        
        let _ = self.localizer?.setupLanguageByTitle(kGermanTitle)
        
        let _ = self.localizer?.setupLanguageByTitle("aaa")
        XCTAssertTrue(self.localizer?.languageCode == kGermanCode)
        
        let _ = self.localizer?.setupLanguageByTitle("")
        XCTAssertTrue(self.localizer?.languageCode == kGermanCode)
    }
    
    func testD_SetupBigLanguageCode() {
        self.localizer?.languageCode = "cs_CZ"
        XCTAssertTrue(self.localizer?.languageCode == kCzechCode)
    }
  
    func testE1_TraslateWordCorrect() {
        self.localizer?.languageCode = kGermanCode
        XCTAssertTrue(self.localizer?.local("Game") == "Spiel")
    }
    
    func testE2_TraslateWordCorrectViaStringExtension () {
        self.localizer?.languageCode = kGermanCode
        XCTAssertTrue("Game".localized() == "Spiel")
    }
    
    func testF_TraslateWordIncorrect() {
        self.localizer?.languageCode = kGermanCode
        XCTAssertTrue(self.localizer?.local("GameX") == "GameX")
    }
    
    func testG1_ListTitle() {
        let titleArray = self.localizer?.languagesListTitle()
        
        XCTAssertTrue(titleArray?.count == kLanguageCount)
        
        XCTAssertTrue((titleArray?.contains(kEnglishTitle))!)
        XCTAssertTrue((titleArray?.contains(kCzechTitle))!)
        XCTAssertTrue((titleArray?.contains(kGermanTitle))!)
        XCTAssertTrue((titleArray?.contains(kRussianTitle))!)
        XCTAssertTrue((titleArray?.contains(kUkrainianTitle))!)
    }
    
    func testG2_ListCode() {
        let codeArray = RYLocalizer.shared.languagesListCode()
        
        let countCorrect = codeArray.count == kLanguageCount
        let containsCorrect =
                codeArray.contains(kEnglishCode) &&
                codeArray.contains(kCzechCode) &&
                codeArray.contains(kGermanCode) &&
                codeArray.contains(kRussianCode) &&
                codeArray.contains(kUkrainianCode)
        
        XCTAssertTrue(countCorrect && containsCorrect)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
