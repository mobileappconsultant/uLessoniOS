import SwiftUI
import UniformTypeIdentifiers

import Lottie

struct InventoryItem: Identifiable {
    var id: String
    let partNumber: String
    let quantity: Int
    let name: String
}

struct ContentView: View {
    @State var presented = true
    
    var body: some View {
        NavigationStack {
            HomeScreen()
        }
    }
}

#Preview {
    ContentView()
}
