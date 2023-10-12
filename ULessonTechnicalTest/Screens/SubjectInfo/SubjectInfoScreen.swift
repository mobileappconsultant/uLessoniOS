import SwiftUI

struct SubjectInfoScreen: View {
    let subject: Subject
    @StateObject private var viewModel = SubjectInfoViewModel()
    
    var body: some View {
        ZStack {
            BackgroundDesign()
            
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: 24
                ) {
                    if (viewModel.uiState == .idle) {
                        VStack(
                            alignment: .leading,
                            spacing: 16
                        ) {
                            Text(subject.title)
                                .font(.title2)
                                .bold()
                            
                            Text("\(viewModel.chapters.count) chapters / \(viewModel.lessonCount()) lessons")
                            
                            LessonSearch(query: $viewModel.searchQuery)
                        }.padding(Edge.Set.top, 50)
                        
                        if (viewModel.resumeLearningProgress != nil) {
                            Text("Resume Learning")
                                .font(.title3)
                                .bold()
                            
                            ResumeLearning(
                                title: viewModel.resumeLearningProgress!.lesson.title,
                                subtitle: "You've watched \(viewModel.lessonIndex(viewModel.resumeLearningProgress!.lesson) + 1) of \(viewModel.lessonCount()) lessons"
                            ) {
                                viewModel.resumeLearning(viewModel.resumeLearningProgress!.lesson)
                            }
                        }
                        
                        Text("Chapters")
                            .font(.title2)
                            .bold()
                        
                        Chapters(chapters: viewModel.chapters.filter { chapter in
                            viewModel.searchQuery.isEmpty || chapter.title.lowercased().contains(viewModel.searchQuery.lowercased())
                        }) { lesson in
                            viewModel.lessonSelected(lesson)
                        }
                        
                    } else if (viewModel.uiState == .loading) {
                        VStack(
                            alignment: .center,
                            spacing: 12
                        ) {
                            ProgressView()
                            Text("Loading Chapters")
                        }.frame(maxWidth: .infinity)
                    } else { // Error
                        // Do nothing, cause we never reach this
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(24)
                .navigationDestination(isPresented: $viewModel.goToPlayer) {
                    if (viewModel.selectedLesson != nil) {
                        VideoPlayerScreen(
                            lessons: viewModel.getLessons(),
                            index: viewModel.getLessonIndex()
                        )
                    }
                }
                .onAppear {
                    viewModel.loadChapters(subject: subject)
                }
            }
        }
    }
}

#Preview {
    SubjectInfoScreen(
        subject: Subject(title: "Biology", image: "some image")
    )
}
