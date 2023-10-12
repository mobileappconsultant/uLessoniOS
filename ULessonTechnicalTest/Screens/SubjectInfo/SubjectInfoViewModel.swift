import Foundation
import ulessonshared

@MainActor class SubjectInfoViewModel: ObservableObject {
    @Published var resumeLearningProgress: LearningProgress?
    @Published var uiState: UIState = .idle
    @Published var chapters: [Chapter] = []
    @Published var searchQuery = ""
    @Published var toastMessage: String?
    @Published var goToPlayer = false
    @Published var selectedLesson: Lesson?
    
    private let getChaptersUseCase = GetChaptersUseCase()
    private let resumeLearningUseCase = ResumeLearningUseCase()
    
    func loadChapters(subject: Subject) {
        Task {
            uiState = .loading
            
            let response = try await getChaptersUseCase.getChapters(subject: subject.title)
            if (response.hasError) {
                toastMessage = response.error?.message ?? "Unknown error"
            } else {
                chapters = ((response.value as? [Chapter]) ?? [])
                print("Chapter count: \(chapters.count)")
            }
            
            resumeLearningProgress = resumeLearningUseCase.getSavedProgress()
            
            uiState = .idle
        }
    }
    
    func lessonCount() -> Int {
        chapters.reduce(0) { partialResult, chapter in
            return partialResult + chapter.lessons.count
        }
    }
    
    func getLessons() -> [Lesson] {
        if (selectedLesson == nil) {
            return []
        }

        let chapter = chapters.first { chapter in
            return chapter.lessons.contains(selectedLesson!)
        }
        
        return chapter?.lessons ?? []
    }
    
    func lessonIndex(_ lesson: Lesson) -> Int {
        let chapter = chapters.first { chapter in
            return chapter.lessons.contains(lesson)
        }
        
        return chapter!.lessons.firstIndex { l in
            lesson.videoUrl == l.videoUrl
        } ?? 0
    }
    
    func resumeLearning(_ lesson: Lesson) {
        selectedLesson = lesson
        goToPlayer = true
    }
    
    func getLessonIndex() -> Int {
        let lessons = getLessons()
        return lessons.firstIndex { lesson in
            lesson.title == selectedLesson!.title && lesson.videoUrl == selectedLesson!.videoUrl
        } ?? -1
    }
    
    func lessonSelected(_ lesson: Lesson) {
        selectedLesson = lesson
        
        goToPlayer = true
    }
}
