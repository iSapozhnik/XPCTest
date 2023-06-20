//
//  NSImage+Extensions.swift
//  XPCTest
//
//  Created by Ivan Sapozhnik on 20.06.23.
//

import Foundation
import AppKit

extension NSImage {
    static func windowInfo(_ completion: @escaping ([String]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let windows = CGWindowListCopyWindowInfo(
                CGWindowListOption.optionAll,
                CGWindowID(0)
            )! as! [[String: Any]]

            guard let jsonData = try? JSONSerialization.data(withJSONObject: windows, options: [.prettyPrinted]) else {
                print("Could not serialize data into JSON")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            guard let windows = try? JSONDecoder().decode(ScreenCapture.Windows.self, from: jsonData) else {
                print("Could not decode data into Windows onject")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            let windowsWithPicture: [ScreenCapture.Window] = windows
                .filter { $0.kCGWindowOwnerName == "Dock" }
                .compactMap { $0.kCGWindowName == nil ? nil : $0 }
                .filter { $0.kCGWindowName!.contains("Picture") }
                .sorted { a, b in
                    a.kCGWindowNumber > b.kCGWindowNumber
                }
            
            DispatchQueue.main.async {
                completion(windowsWithPicture.compactMap(\.kCGWindowName))
            }
        }
    }
}
