//
//  ContentView.swift
//  Debugging
//
//  Created by Jungman Bae on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var message = "Temperature in Celsius: "
    let temp = 100.0
    
    var body: some View {
        VStack {
            Text(message + "\(temp)")
            Text("Temperature in Fahrenheit: \(C2F(tempC: temp))")
        }
    }
    
    func C2F (tempC: Double) -> Double {
        var tempF: Double
        tempF = (tempC * 9/5) + 32
        return tempF
    }
}

#Preview {
    ContentView()
}
