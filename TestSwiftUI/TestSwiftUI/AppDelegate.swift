//
//  AppDelegate.swift
//  TestSwiftUI
//
//  Created by Кирилл Щёлоков on 03.07.2024.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    let pushNotificationManager = PushNotificationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        pushNotificationManager.requestNotificationAuthorization()
        return true
    }
}
