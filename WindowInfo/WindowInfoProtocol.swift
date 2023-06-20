//
//  WindowInfoProtocol.swift
//  WindowInfo
//
//  Created by Ivan Sapozhnik on 20.06.23.
//

import Foundation

@objc public protocol WindowInfoProtocol {
    func windowInfo(_ completion: @escaping ([String]) -> Void)
}
