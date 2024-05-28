//
//  AddJournalEntryView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isGetLocationOn = false
    @State private var entrytitle = ""
    @State private var entryBody = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header : Text("rating")) {
                    Rectangle()
                        .foregroundStyle(.cyan)
                }
                Section(header : Text("Location")){
                    Toggle("Get Location", isOn: $isGetLocationOn)
                }
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $entrytitle)
                }
                Section(header: Text("Body")) {
                    TextEditor("Enter Body", text: $entryBody)
                }
                Section(header: Text("Photo")) {
                    TextField("Enter Body", text: $entryBody)
                }
            }
            Text("Add JournalEntry")
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
                            dismiss()
                        }
                    }
                }
        }
    }
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
