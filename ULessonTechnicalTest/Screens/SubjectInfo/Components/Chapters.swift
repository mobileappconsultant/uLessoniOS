import SwiftUI
import ulessonshared

struct Chapters: View {
    let chapters: [Chapter]
    let onLessonSelected: (Lesson) -> Void
    
    var body: some View {
        VStack(
            spacing: 16
        ) {
            ForEach(chapters, id: \.title) { chapter in
                ChapterCard(chapter: chapter, onLessonSelected: onLessonSelected)
            }
        }.navigationTitle(Text("Chapters"))
    }
}

#Preview {
    Chapters(chapters: []) { lesson in
        
    }
}
