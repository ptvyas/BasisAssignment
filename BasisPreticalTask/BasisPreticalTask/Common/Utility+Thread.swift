//
//  Utility+Thread.swift
//  BasisPreticalTask
//
//  Created by Vyas on 13/07/22.
//

import Foundation

/// Runs a block after given time
public func runAfterTime(time: Double, block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
        block()
    })
}

/// Runs a block in the main thread
public func runOnMainThread(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}
