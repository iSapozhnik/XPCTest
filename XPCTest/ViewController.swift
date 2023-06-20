//
//  ViewController.swift
//  XPCTest
//
//  Created by Ivan Sapozhnik on 20.06.23.
//

import Cocoa
import WindowInfo

class ViewController: NSViewController {
    private let xpc: WindowInfoProtocol? = {
        let connectionToService = NSXPCConnection(serviceName: "com.heavylightapps.WindowInfo")
        connectionToService.remoteObjectInterface = NSXPCInterface(with: WindowInfoProtocol.self)
        connectionToService.resume()
        return connectionToService.remoteObjectProxy as? WindowInfoProtocol
    }()
    
    @IBAction func onNormal(_ sender: Any) {
        guard askForAccessibilityIfNeeded() else { return }

        NSImage.windowInfo { windowNames in
            print("APP Window names: \(windowNames)")
        }
    }
    
    @IBAction func onXPC(_ sender: Any) {
        guard askForAccessibilityIfNeeded() else { return }
        
        xpc?.windowInfo { windowNames in
            print("XPC Window names: \(windowNames)")
        }
    }
    
    private func askForAccessibilityIfNeeded() -> Bool {
        let key: String = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let options = [key: true]
        let enabled = AXIsProcessTrustedWithOptions(options as CFDictionary)

        if enabled {
            return true
        }

        let alert = NSAlert()
        alert.messageText = "Enable Accessibility First"
        alert.informativeText = "Find the popup right behind this one, click \"Open System Preferences\" and enable XPCTest. Then launch XPCTest again."
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Quit")
        alert.runModal()
        NSApp.terminate(nil)
        return false
    }
}

