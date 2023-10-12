import SwiftUI
import ulessonshared

struct LessonList: View {
    
    let lessonList: [Lesson]
    let onLessonSelected: (Lesson) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(lessonList, id: \.title) { lesson in
                LessonTile(lesson: lesson) {
                    onLessonSelected(lesson)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    LessonList(lessonList: [
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: ""),
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: ""),
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: "")
    ]) { lesson in }
}
