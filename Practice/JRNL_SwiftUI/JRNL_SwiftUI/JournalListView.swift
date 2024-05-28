//
//  JournalListView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI

struct JournalListView: View {
    @State private var isShowwAddJournal =  false
    
    var body : some view {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Journal List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button( "Add", systemImage: "plus"){
                        print("add")
                        
                    }
                }
                
            }
            .sheet(isPresented: $isShowwAddJournal) {
                AddJournalEntryView()
                
            }
                   }
    }
}


#Preview {
    JournalListView()
}
