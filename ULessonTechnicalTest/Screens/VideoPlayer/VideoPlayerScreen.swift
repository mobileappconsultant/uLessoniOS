import SwiftUI
import AVKit

import ulessonshared

struct VideoPlayerScreen: View {
    let lessons: [Lesson]
    let index: Int
    @StateObject var viewModel = VideoPlayerViewModel()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(lessons: [Lesson], index: Int) {
        self.lessons = lessons
        self.index = index
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            VideoPlayer(
                player: viewModel.player
            ).frame(maxHeight: 300)
            
            Button(action: {
                viewModel.triggerAddBookmark()
            }) {
                Image(systemName: "bookmark.fill")
                    .font(.title2)
            }.buttonStyle(.plain)
                .padding()
            
            Text(viewModel.getCurrentLesson()?.title ?? "")
                .font(.title3)
                .bold()
                .padding(Edge.Set.horizontal)
            
            Text("Bookmarks")
                .font(.footnote)
                .bold()
                .padding(Edge.Set.horizontal)
                .padding(Edge.Set.top, 20)
            
            Divider()
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.bookmarks, id: \.timestamp) { bookmark in
                    BookmarkItem(bookmark: bookmark, onClick: {
                        viewModel.bookmarkSelected(bookmark)
                    }) {
                        viewModel.removeBookmark(bookmark)
                    }
                }
            }.padding()
            
            Spacer()
        }.onAppear {
            viewModel.initialize(lessons, index)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
            viewModel.saveCurrentVideo()
        }) {
            Image(systemName: "arrow.left")
            Text("Chapters")
        })
        .navigationTitle(Text("Player"))
            .overlay {
                if viewModel.showAddBookmark {
                    AddBookmarkDialog { value in
                        viewModel.saveBookmark(value)
                    }
                }
            }
    }
}

#Preview {
    VideoPlayerScreen(
        lessons: [
            Lesson(
                title: "The Three Domains Of Life",
                videoUrl: "https://res.cloudinary.com/mobile-paradigm/video/upload/v1693217516/BIO10_02_07_02_zftrtq.mp4"
            ),
            Lesson(
                title: "The Three Domains Of Life",
                videoUrl: "https://res.cloudinary.com/mobile-paradigm/video/upload/v1693217531/BIO10_03_01_06_NEW_zqbhdv.mp4"
            )
        ],
        index: 0
    )
}
