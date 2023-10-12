import SwiftUI

struct AddBookmarkDialog: View {
    let onClick: (String) -> Void
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            VStack(
                spacing: 20
            ) {
                Text("Add Bookmark")
                    .font(.title2)
                    .bold()
                
                TextField("Enter bookmark name", text: $text)
                    .textFieldStyle(.roundedBorder)
                
                Divider()
                
                Button("Submit") {
                    onClick(text)
                }
            }
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .padding()
            .background(.regularMaterial)
            .cornerRadius(16.0)
        }.padding()
    }
}

#Preview {
    AddBookmarkDialog { text in }
}
