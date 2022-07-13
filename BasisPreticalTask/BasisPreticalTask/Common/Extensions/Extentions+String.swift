//
//  Extentions+String.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
   }
}
