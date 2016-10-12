//
//  String + substrings.swift
//  FPSwift3
//
//  Created by Dario on 10/11/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import Foundation

extension String
{
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        
        return self[start...end]
    }
}
