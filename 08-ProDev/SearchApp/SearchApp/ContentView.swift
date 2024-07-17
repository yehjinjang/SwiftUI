import SwiftUI

struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let tags: [String]
}

struct ContentView: View {
    @State private var searchText = ""
    
    let pets = [
        Pet(name: "Cat", tags: ["Land"]),
        Pet(name: "Dog", tags: ["Land"]),
        Pet(name: "Fish", tags: ["Water"]),
        Pet(name: "Donkey", tags: ["Land"]),
        Pet(name: "Canary", tags: ["Air"]),
        Pet(name: "Camel", tags: ["Land"]),
        Pet(name: "Frog", tags: ["Water", "Land"])
    ]
    
    var filteredPets: [Pet] {
        if searchText.isEmpty {
            return pets
        } else {
            return pets.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) }) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPets) { pet in
                Text(pet.name)
            }
            .navigationTitle("SearchApp")
            .searchable(text: $searchText, prompt: "Look for a pet")
        }
    }
}

#Preview {
    ContentView()
}
