import Foundation
import AVKit

import ulessonshared

@MainActor class VideoPlayerViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var index: Int = 0
    @Published var player: AVQueuePlayer?
    @Published var showAddBookmark = false
    @Published var temporaryPause = false
    @Published var bookmarks: [Bookmark] = []
    
    private var playlist: [AVPlayerItem] = []
    
    private let addBookmarkUseCase = AddBookmarkUseCase()
    private let getBookmarksUseCase = GetBookmarksUseCase()
    private let deleteBookmarkUseCase = DeleteBookmarkUseCase()
    private let resumeLearningUseCase = ResumeLearningUseCase()
    
    func initialize(_ lessons: [Lesson], _ index: Int) {
        self.lessons = lessons
        self.index = index
        
        bookmarks = getBookmarksUseCase.getBookmarks(lesson: getCurrentLesson()!)
        
        for lesson in lessons.dropFirst(self.index) {
            guard let url = URL(string: lesson.videoUrl) else {
                fatalError("Could not load \(lesson.videoUrl)")
            }
            let playerItem = AVPlayerItem(url: url)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.receiveNotification(notification:)), name: AVPlayerItem.didPlayToEndTimeNotification, object: nil)
            
            playlist.append(playerItem)
        }
        
        player = AVQueuePlayer(items: playlist)
        
        let savedProgress = resumeLearningUseCase.getSavedProgress()
        if savedProgress?.lesson.videoUrl == lessons[index].videoUrl {
            Task {
                player?.seek(to: CMTime(value: savedProgress!.timestamp, timescale: 1000))
                player?.play()
            }
        } else {
            player?.play()
        }
    }
    
    func getCurrentLesson() -> Lesson? {
        if lessons.count > index {
            return lessons[index]
        }
        
        return nil
    }
    
    func triggerAddBookmark() {
        let currentVideoURL: String? = (player?.currentItem?.asset as? AVURLAsset)?.url.absoluteString
        if currentVideoURL == nil {
            return
        }
        
        if (player?.rate != 0) && (player?.error == nil) {
            temporaryPause = true
            player?.pause()
        }
        
        showAddBookmark = true
    }
    
    func saveBookmark(_ text: String) {
        let time: Int64 = Int64(player!.currentTime().seconds * 1000)
        addBookmarkUseCase.addBookmark(lesson: getCurrentLesson()!, bookmark: Bookmark(note: text, timestamp: time))
        showAddBookmark = false
        bookmarks = getBookmarksUseCase.getBookmarks(lesson: getCurrentLesson()!)
        
        if temporaryPause {
            temporaryPause = false
            player?.play()
        }
    }
    
    func bookmarkSelected(_ bookmark: Bookmark) {
        Task {
            await player?.seek(to: CMTime(value: bookmark.timestamp, timescale: 1000))
        }
    }
    
    func removeBookmark(_ bookmark: Bookmark) {
        deleteBookmarkUseCase.deleteBookmark(lesson: getCurrentLesson()!, bookmark: bookmark)
        bookmarks = getBookmarksUseCase.getBookmarks(lesson: getCurrentLesson()!)
    }
    
    func saveCurrentVideo() {
        guard let currentLesson = getCurrentLesson() else { return }
        guard let currentItem = player?.currentItem else { return }
        
        let currentTime = Int64(player!.currentTime().seconds * 1000)
        let duration = Int64(currentItem.duration.seconds * 1000)
        
        if currentTime < duration {
            resumeLearningUseCase.saveLessonProgress(lesson: currentLesson, timestamp: currentTime)
        } else {
            resumeLearningUseCase.clearProgress()
        }
    }
    
    @objc func receiveNotification(notification: Notification) {
        resumeLearningUseCase.clearProgress()
        print("Some notification: \(notification)")
        let currentVideoURL: String? = (player?.currentItem?.asset as? AVURLAsset)?.url.absoluteString
        if currentVideoURL == nil {
            return
        }
        
        index = lessons.firstIndex(where: { lesson in
            lesson.videoUrl == currentVideoURL
        }) ?? index
        
        bookmarks = getBookmarksUseCase.getBookmarks(lesson: getCurrentLesson()!)
    }
}
