//
//  MotionAppApp.swift
//  MotionApp
//
//  Created by Jungman Bae on 7/3/24.
//

import SwiftUI

@main
struct MotionAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DeviceMotionView()
            }
        }
    }
}
