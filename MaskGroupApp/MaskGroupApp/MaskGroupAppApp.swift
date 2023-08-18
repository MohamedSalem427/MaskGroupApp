//
//  MaskGroupAppApp.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI
import IQKeyboardManagerSwift
import UIKit
import netfox

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        KeyboardWrapper.handleKeyboardAppearance()
        NFX.sharedInstance().start()
        NFX.sharedInstance().setGesture(.shake)
        return true
    }
}

@main
struct MaskGroupAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if let isLoggedIn: Bool = UserDefaults.standard.get(.isLoggedIn) {
                if isLoggedIn  {
                    HomeScreen(vm: .init())
                }
            }else {
                LoginScreen(vm: .init())
            }
        }
    }
}
