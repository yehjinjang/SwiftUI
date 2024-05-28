//
//  ContentView.swift
//  LazyStacks
//
//  Created by Jungman Bae on 4/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(1...10000, id: \.self) { item in
                        ListRow(id: item, type: "Horizontal")
                    }
                }
            }
            .frame(height: 100, alignment: .center)
            
        }
    }
}

#Preview {
    ContentView()
}
