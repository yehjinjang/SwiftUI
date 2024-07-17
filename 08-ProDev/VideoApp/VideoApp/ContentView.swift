//
//  ContentView.swift
//  VideoApp
//
//  Created by Jungman Bae on 7/5/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player) {
            VStack {
                Text("Overlay text to appear")
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 320)
        .onAppear {
            guard let videoURL = Bundle.main.url(forResource: "SaturnV", withExtension: "mov") else {
                print("Video file not found")
                return
            }
            player = AVPlayer(url: videoURL as URL)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
