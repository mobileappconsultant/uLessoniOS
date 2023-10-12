import SwiftUI
import ulessonshared

struct ChapterCard: View {
    let chapter: Chapter
    let onLessonSelected: (Lesson) -> Void
    @State var expanded = false
    
    var body: some View {
        VStack(
            spacing: 12
        ) {
            Button(action: {
                withAnimation {
                    expanded.toggle()
                }
            }) {
                HStack(
                    alignment: .center
                ) {
                    Image("chapter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                    
                    VStack(
                        spacing: 12
                    ) {
                        HStack(
                            alignment: .center,
                            spacing: 12
                        ) {
                            Text("Chapter 1")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(chapter.lessons.count) Lessons")
                                .padding(Edge.Set.all, 8.0)
                                .background(.regularMaterial)
                                .cornerRadius(8)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(
                            spacing: 12
                        ) {
                            Text(chapter.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                            
                            Image(systemName: expanded ? "arrow.uturn.down.circle.fill" : "arrow.uturn.up.circle.fill")
                                .font(.title2)
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }.buttonStyle(.plain)
            
            if (expanded) {
                LessonList(lessonList: chapter.lessons, onLessonSelected: onLessonSelected)
                    .transition(.scale)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ChapterCard(chapter: Chapter(title: "Introduction To Biology And Amalgamatoral Obligations", lessons: [
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: ""),
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: ""),
        Lesson(title: "Recognizing Living Things: Is it Alive?", videoUrl: "")
    ])) {_ in
        
    }
}
