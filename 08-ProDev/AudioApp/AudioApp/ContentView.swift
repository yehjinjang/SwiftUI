//
//  ContentView.swift
//  AudioApp
//
//  Created by Jungman Bae on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    var audioPlayerManger = AudioPlayerManager()
    
    @State var playAudio = false
    
    var body: some View {
        VStack {
            Button(action: {
                if !playAudio {
                    audioPlayerManger.play()
                } else {
                    audioPlayerManger.pause()
                }
                playAudio.toggle()
            }, label: {
                Text(!playAudio ? "Play audio" : "Pause audio")
            })
        }
        .padding()
        .onAppear {
            audioPlayerManger.loadAudio(name: "Small World", withExtension: "mp3")
        }
    }
}

#Preview {
    ContentView()
}
