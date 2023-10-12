import SwiftUI

struct LessonSearch: View {
    let query: Binding<String>
    
    var body: some View {
        TextField("Search for a lesson or topic", text: query)
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

struct LessonSearchPreview: View {
    @State private var query: String = ""
    
    var body: some View {
        LessonSearch(query: $query)
    }
}

#Preview {
    LessonSearchPreview()
}
