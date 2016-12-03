//
//  StringExtension.swift
//  RYLocalizer
//
//  Created by Yury Radchenko on 28.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import Foundation

extension String {
    
    func first(charsCount: Int) -> String {
        let toIndex = self.characters.index(self.startIndex, offsetBy: charsCount)
        return self.substring(to: toIndex)
    }
    
    func localized() -> String {
        return RYLocalizer.shared.local(self)
    }
}
