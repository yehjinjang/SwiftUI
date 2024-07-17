//
//  SwiftUIView.swift
//  BindingApp
//
//  Created by Jungman Bae on 7/2/24.
//

import SwiftUI

struct DisplayTextField: View {
    @Binding var newVariable: String
    var  body: some View {
        HStack {
            Text("Send a greeting:")
            TextField("Type a message here", text: $newVariable)
        }
    }
}

#Preview {
    DisplayTextField(newVariable: .constant(""))
}
