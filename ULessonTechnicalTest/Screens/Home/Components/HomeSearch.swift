import SwiftUI

struct HomeSearch: View {
    let query: Binding<String>
    
    var body: some View {
        TextField("What would you like to learn?", text: query)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(Color(UIColor.lightGray))
                
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                }.padding()
            }
    }
}

struct HomeSearchPreview: View {
    @State private var query: String = ""
    
    var body: some View {
        HomeSearch(query: $query)
    }
}

#Preview {
    HomeSearchPreview()
}
