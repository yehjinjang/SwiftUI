//
//  ContentView.swift
//  DisclosureGroups
//
//  Created by Jungman Bae on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showplanets = true
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $showplanets) {
                Text("Mercury")
                Text("Venus")
                DisclosureGroup("Earth") {
                    Text("North America")
                    Text("South America")
                    Text("Europe")
                    Text("Africa")
                    Text("Asia")
                    Text("Antarctica")
                    Text("Oceania")
                }
            } label: {
                Text("Planets")
            }
            DisclosureGroup {
                Text("Surprise! This is an alternative way of using DisclosureGroup")
            } label: {
                Label("Tap to reveal", systemImage: "cube.box")
                    .font(.system(size: 25, design: .rounded))
                    .foregroundStyle(.blue)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
