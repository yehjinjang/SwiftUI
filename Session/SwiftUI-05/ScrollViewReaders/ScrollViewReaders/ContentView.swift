//
//  ContentView.swift
//  ScrollViewReaders
//
//  Created by Jungman Bae on 4/25/24.
//

import SwiftUI


struct ContentView: View {
    @State private var scrolledID: CharacterInfo.ID?
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("iOS 17+")
                    .foregroundStyle(.blue)
                    .font(.title)
                ScrollView {
                    Button("Go to letter Q") {
                        scrolledID = 11
                    }
                    .padding()
                    .background(.blue)
                    .tint(.yellow)
                    
                    ForEach(CharacterInfo.charArray, id: \.id) { image in
                        Image(systemName: image.name)
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                            .frame(width: 90, height: 90)
                            .background(.yellow)
                            .padding()
                    }
                    
                    Button("Go to letter G") {
                        withAnimation {
                            scrolledID = 0
                        }
                    }
                    .padding()
                    .background(.blue)
                    .tint(.yellow)
                }
                .scrollPosition(id: $scrolledID, anchor: .bottom)
            }
            VStack {
                Text("iOS 14+")
                    .foregroundStyle(.blue)
                    .font(.title)
                ScrollView {
                    ScrollViewReader { proxy in
                        Button("Go to letter Q") {
                            proxy.scrollTo(16)
                        }
                        .padding()
                        .background(.yellow)
                        .tint(.blue)
                        
                        ForEach(CharacterInfo.charArray, id: \.id) { image in
                            Image(systemName: image.name)
                                .font(.largeTitle)
                                .foregroundStyle(.yellow)
                                .frame(width: 90, height: 90)
                                .background(.blue)
                                .padding()
                        }
                        
                        Button("Go to letter G") {
                            withAnimation {
                                proxy.scrollTo(6, anchor: .top)
                            }
                        }
                        .padding()
                        .background(.yellow)
                        .tint(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
