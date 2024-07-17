//
//  ContentView.swift
//  UserDefaultsApp
//
//  Created by Jungman Bae on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var myText = ""
    @State private var myToggle = true
    @State private var mySlider = 0.0
    
    var body: some View {
        VStack {
            TextField("Change text here", text: $myText)
            Toggle(isOn: $myToggle) {
                Text("Toggle here")
            }
            Slider(value: $mySlider)
            Button(action: {
                UserDefaults.standard.set(myText, forKey: "Text")
                UserDefaults.standard.set(myToggle, forKey: "Toggle")
                UserDefaults.standard.set(mySlider, forKey: "Slider")
            }) {
                Text("Save data")
            }
            Button(action: {
                myText = ""
                myToggle = true
                mySlider = 0.0
            }) {
                Text("Clear data")
            }
            Button(action: {
                myText = UserDefaults.standard.string(forKey: "Text") ?? ""
                myToggle = UserDefaults.standard.bool(forKey: "Toggle")
                mySlider = UserDefaults.standard.double(forKey: "Slider")
            }) {
                Text("Retrieve data")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
