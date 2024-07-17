//
//  ContentView.swift
//  ReadWriteApp
//
//  Created by Jungman Bae on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let placeHolder = "텍스트를 입력하세요."
    @State var userCreated = false
    @State var createText = "텍스트를 입력하세요."
    @State var displayText = ""
    
    // 입력에 대한 포커스 상태 변수
    @FocusState var textFieldFocus: Bool
    
    var textDisabled: Bool {
        placeHolder == createText && !textFieldFocus && !userCreated
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $createText)
                // 플레이스홀더가 표시되어있으면, 텍스트 색상을 회색으로 변경
                .foregroundStyle(textDisabled ? .gray : .black)
                .focused($textFieldFocus)
                .onChange(of: textFieldFocus) {
                    // 텍스트필드에 포커스 이동시 플레이스홀더가 표시되어 있으면,
                    // 입력 텍스트 필드를 초기화하고 입력 대기상태로 만듬
                    if textFieldFocus, placeHolder == createText, !userCreated {
                        createText = ""
                        userCreated = true
                    // 다른 입력으로 포커스 이동시, 입력한 텍스트가 없으면,
                    // 플레이스홀더 기본 텍스트로 대치
                    } else if !textFieldFocus, createText.isEmpty {
                        createText = placeHolder
                        userCreated = false
                    }
                }
            HStack {
                Button(action: {
                    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("File writing error")
                    }
                }) {
                    Text("Write File")
                }
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File reading error")
                    }
                }) {
                    Text("Read File")
                }
            }
            .padding()
            TextEditor(text: $displayText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
