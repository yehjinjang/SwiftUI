//
//  AddJournalEntryView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI
import CoreLocation

struct AddJournalEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var rating = 0
    @State private var isGetLocationOn = false
    @State private var locationLabel = "Get Location"
    @State private var currentLocation: CLLocation?
    @State private var entryTitle = ""
    @State private var entryBody = ""
    @State private var isShowPicker = false
    @State private var uiImage: UIImage?
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    RatingView(rating: $rating)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section(header: Text("Location")) {
                    Toggle(locationLabel, isOn: $isGetLocationOn)
                        .onChange(of: isGetLocationOn) {
                            if isGetLocationOn {
                                locationLabel = "Get Location..."
                                locationManager.requestLocation()
                            } else {
                                locationLabel = "Get Location"
                            }
                        }
                        .onReceive(locationManager.$location) { location in
                            if isGetLocationOn {
                                currentLocation = location
                                locationLabel = "Done"
                            }
                        }
                }
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $entryTitle)
                }
                Section(header: Text("Body")) {
                    TextEditor(text: $entryBody)
                }
                Section(header: Text("Photo")) {
                    if let image = uiImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding()
                            .onTapGesture {
                                isShowPicker = true
                            }
                    } else {
                        Image(systemName: "face.smiling")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding()
                            .onTapGesture {
                                isShowPicker = true
                            }
                    }
                }
            }
            .navigationTitle("Add Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let journalEntry = JournalEntry(rating: rating, entryTitle: entryTitle,
                                                        entryBody: entryBody,
                                                        photo: uiImage,
                                                        latitude: currentLocation?.coordinate.latitude,
                                                        longitude: currentLocation?.coordinate.longitude)
                        modelContext.insert(journalEntry)
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: $uiImage)
            }
        }
    }
}

#Preview {
    AddJournalEntryView()
}
//struct AddJournalEntryView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var journalEntries: [JournalEntry]
//    
//    @State private var entryTitle: String = ""
//    @State private var entryBody: String = ""
//    @State private var rating: Int = 3
//    @State private var photo: UIImage? = UIImage(systemName: "face.smiling")
//    @State private var showingImagePicker = false
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Entry Title")) {
//                    TextField("Title", text: $entryTitle)
//                }
//                Section(header: Text("Entry Body")) {
//                    TextField("Body", text: $entryBody)
//                }
//                Section(header: Text("Rating")) {
//                    Picker("Rating", selection: $rating) {
//                        ForEach(1..<6) {
//                            Text("\($0) Stars")
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//                Section(header: Text("Photo")) {
//                    Button(action: {
//                        showingImagePicker = true
//                    }) {
//                        Image(uiImage: photo ?? UIImage(systemName: "face.smiling")!)
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//            }
//            .navigationTitle("New Journal Entry")
//            .navigationBarItems(trailing: Button("Save") {
//                let newEntry = JournalEntry(date: Date(), entryTitle: entryTitle, entryBody: entryBody, rating: rating, photo: photo, latitude: nil, longitude: nil)
//                journalEntries.append(newEntry)
//                presentationMode.wrappedValue.dismiss()
//            })
//            .sheet(isPresented: $showingImagePicker) {
//                ImagePicker(image: $photo)
//            }
//        }
//    }
//}
