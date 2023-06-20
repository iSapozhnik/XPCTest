//
//  ScreenCapture.swift
//  XPCTest
//
//  Created by Ivan Sapozhnik on 20.06.23.
//

import Foundation

enum ScreenCapture {
    typealias Windows = [Window]

    struct Window: Codable {
        let kCGWindowNumber: Int
        let kCGWindowOwnerName: String
        let kCGWindowName: String?
    }
}
