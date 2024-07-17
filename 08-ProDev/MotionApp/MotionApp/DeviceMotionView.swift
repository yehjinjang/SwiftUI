//
//  DeviceMotionView.swift
//  MotionApp
//
//  Created by Jungman Bae on 7/3/24.
//

import SwiftUI
import CoreMotion

struct DeviceMotionView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var roll: Double = 0.0

    var body: some View {
        VStack {
            Text("Pitch: \(pitch)")
            Text("Yaw: \(yaw)")
            Text("Roll: \(roll)")
        }
        .navigationTitle("DeviceMotion")
        .onAppear {
            motionManager.startDeviceMotionUpdates(to: queue) {
                (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                let trackMotion: CMAttitude = data.attitude
                motionManager.deviceMotionUpdateInterval = 0.5
                DispatchQueue.main.async {
                    pitch = trackMotion.pitch
                    yaw = trackMotion.yaw
                    roll = trackMotion.roll
                }
            }

        }
    }
}

#Preview {
    DeviceMotionView()
}
