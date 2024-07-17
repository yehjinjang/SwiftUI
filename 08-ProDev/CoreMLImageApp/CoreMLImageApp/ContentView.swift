//
//  ContentView.swift
//  CoreMLImageApp
//
//  Created by 장예진 on 7/9/24.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State var message = ""
    @State var arrayIndex = 0
    @State var image: UIImage = UIImage(named: "cat")!
    
    let photoArray = ["cat", "plane", "banana", "car"]
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            TextEditor(text: $message)
                .padding()
            Button {
                useAI(sentImage: photoArray[arrayIndex])
            } label: {
                Text("Analyze Image")
            }.padding()
            
            HStack {
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                }
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                }
            }
        }
        .padding()
    }
    
    func useAI(sentImage: String) {
        guard let uiImage = UIImage(named: sentImage) else {
            message = "Image not found"
            return
        }
        
        guard let ciImage = CIImage(image: uiImage) else {
            message = "Unable to create CIImage"
            return
        }
        
        do {
            let modelFile = try MobileNetV2(configuration: MLModelConfiguration())
            let model = try VNCoreMLModel(for: modelFile.model)
            let handler = VNImageRequestHandler(ciImage: ciImage)
            let request = VNCoreMLRequest(model: model, completionHandler: findResults)
            try handler.perform([request])
        } catch {
            message = "Failed to process image: \(error.localizedDescription)"
        }
    }
    
    func findResults(request: VNRequest, error: Error?) {
        if let error = error {
            message = "Error: \(error.localizedDescription)"
            return
        }
        
        guard let results = request.results as? [VNClassificationObservation] else {
            message = "Unable to classify image."
            return
        }
        
        var bestGuess = ""
        var bestConfidence: VNConfidence = 0
        
        for classification in results {
            if classification.confidence > bestConfidence {
                bestConfidence = classification.confidence
                bestGuess = classification.identifier
            }
        }
        message = "Image is : \(bestGuess) with confidence \(bestConfidence) out of 1"
    }
}

#Preview {
    ContentView()
}
