//
//  StatusMenuController.swift
//  OpenInTerminal
//
//  Created by Jianing Wang on 2019/4/30.
//  Copyright © 2019 Jianing Wang. All rights reserved.
//

import Cocoa
import OpenInTerminalCore

class StatusMenuController: NSObject, NSMenuDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var defaultTerminalMenuItem: NSMenuItem!
    @IBOutlet weak var defaultEditorMenuItem: NSMenuItem!
    @IBOutlet weak var copyPathMenuItem: NSMenuItem!
    @IBOutlet weak var preferencesMenuItem: NSMenuItem!
    @IBOutlet weak var quitMenuItem: NSMenuItem!
    
    // MARK: Menu life cycle
    
    override func awakeFromNib() {
        Log.logger.directory = "~/Library/Logs/OpenInTerminal"
        #if DEBUG
        Log.logger.name = "OpenInTerminal-debug"
        #else
        Log.logger.name = "OpenInTerminal"
        #endif
        //Edit printToConsole parameter in Edit Scheme > Run > Arguments > Environment Variables
        Log.logger.printToConsole = ProcessInfo.processInfo.environment["print_log"] == "true"
        
//        statusMenu.delegate = self
        
        defaultTerminalMenuItem.title = NSLocalizedString("menu.open_with_default_terminal", comment: "Open with default Terminal")
        defaultEditorMenuItem.title = NSLocalizedString("menu.open_with_default_editor", comment: "Open with default Editor")
        copyPathMenuItem.title = NSLocalizedString("menu.copy_path_to_clipboard", comment: "Copy path to Clipboard")
        preferencesMenuItem.title = NSLocalizedString("menu.preferences", comment: "Preferences...")
        quitMenuItem.title = NSLocalizedString("menu.quit", comment: "Quit")
    }
    
    // MARK: Menu Item Actions
    
    @IBAction func openDefaultTerminal(_ sender: NSMenuItem) {
        (NSApplication.shared.delegate as? AppDelegate)?.openDefaultTerminal()
    }
    
    @IBAction func openDefaultEditor(_ sender: NSMenuItem) {
        (NSApplication.shared.delegate as? AppDelegate)?.openDefaultEditor()
    }
    
    @IBAction func copyPathToClipboard(_ sender: NSMenuItem) {
        (NSApplication.shared.delegate as? AppDelegate)?.copyPathToClipboard()
    }
    
    @IBAction func showPreferences(_ sender: NSMenuItem) {
        let preferencesWindowController = (NSApplication.shared.delegate as? AppDelegate)?.preferencesWindowController
        NSApp.activate(ignoringOtherApps: true)
        preferencesWindowController?.showWindow(sender)
    }
    
    @IBAction func quit(_ sender: NSMenuItem) {
        LaunchNotifier.postNotification(.terminateApp, object: Bundle.main.bundleIdentifier!)
        NSApp.terminate(self)
    }
    
}