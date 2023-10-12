import SwiftUI

struct ResumeLearning: View {
    let title: String
    let subtitle: String
    let onClick: () -> Void
    
    var body: some View {
        Button(
            action: onClick
        ) {
            HStack(
                alignment: .center,
                spacing: 16.0
            ) {
                Image("resume")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50.0)
                
                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    Text(title)
                        .bold()
                    Text(subtitle)
                        .font(.caption)
                }.frame(maxWidth: .infinity)
            }
            .padding(Edge.Set.horizontal, 28)
            .frame(width: .infinity)
            .padding(Edge.Set.vertical, 18)
            .background(Color(red: 0.92, green: 0.44, blue: 0.32))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(
        alignment: .leading
    ) {
        ResumeLearning(title: "Introduction To Biology And Science In General", subtitle: "What happens when we die?") {
            
        }
    }
}
