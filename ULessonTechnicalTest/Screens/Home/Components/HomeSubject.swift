import SwiftUI

struct HomeSubject: View {
    let subject: Subject
    let onClick: () -> Void
    
    init(subject: Subject, onClick: @escaping () -> Void) {
        self.subject = subject
        self.onClick = onClick
    }
    
    var body: some View {
        Button(
            action: onClick
        ) {
            VStack(spacing: 12.0) {
                Image(subject.image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                
                Text(subject.title)
                    .font(.footnote)
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    HomeSubject(subject: HomeViewModel().subjects[0]) {
        
    }
}
