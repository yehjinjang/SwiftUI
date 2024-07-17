//
//  SwiftUIView.swift
//  StoryboardApp
//
//  Created by Jungman Bae on 7/8/24.
//

import SwiftUI

struct SwiftUIView: View {
    var name: String
    
    var body: some View {
        Text("Hello, \(name)")
    }
}

#Preview {
    SwiftUIView(name: "Hanna")
}
