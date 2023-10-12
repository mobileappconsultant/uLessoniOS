import SwiftUI
import ulessonshared

struct LessonTile: View {
    let lesson: Lesson
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            HStack(
                alignment: .center,
                spacing: 12
            ) {
                Image(systemName: "play.fill")
                
                Text(lesson.title)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color(UIColor.lightGray))
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    LessonTile(lesson: Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: "")) {}
}
