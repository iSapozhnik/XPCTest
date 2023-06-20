//
//  WindowInfo.swift
//  WindowInfo
//
//  Created by Ivan Sapozhnik on 20.06.23.
//

import AppKit

final public class WindowInfo: NSObject, WindowInfoProtocol {
    @objc public func windowInfo(_ completion: @escaping ([String]) -> Void) {
        NSImage.windowInfo(completion)
    }
}
