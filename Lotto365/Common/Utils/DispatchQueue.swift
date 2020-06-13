//
//  DispatchQueue.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

func mainThread(_ execute: @escaping () -> Void) {
    DispatchQueue.main.async(execute: {
        execute()
    })
}

func mainThreadAsyncAfter(_ seconds: Double, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        execute()
    }
}

func mainThreadAsyncAfter(_ seconds: Double, execute: DispatchWorkItem) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}

func backgroundThread(_ execute: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async(execute: {
        execute()
    })
}

func backgroundThreadAsyncAfter(_ seconds: Double, execute: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + seconds) {
        execute()
    }
}

func backgroundThreadAsyncAfter(_ seconds: Double, execute: DispatchWorkItem) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + seconds, execute: execute)
}

