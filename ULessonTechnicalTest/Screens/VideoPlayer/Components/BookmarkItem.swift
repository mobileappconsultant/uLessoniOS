import SwiftUI
import ulessonshared

struct BookmarkItem: View {
    
    let bookmark: Bookmark
    let onClick: () -> Void
    let onDelete: () -> Void
    
    func formatMmSsMl(_ counter: Double) -> String {
        let minutes = Int((counter/60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(counter.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        Button(action: onClick) {
            HStack(alignment: .center, spacing: 8) {
                Text(formatMmSsMl(Double(bookmark.timestamp) / 1000))
                Text(bookmark.note)
                    .frame(maxWidth: .infinity)
                Button(action: onDelete) {
                    Image(systemName: "trash.fill")
                        .font(.title2)
                }.buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    BookmarkItem(bookmark: Bookmark(note: "Some bookmarks are too long to be not bookmarked in a way that is bookmarkable", timestamp: 2000), onClick: {}) {
        
    }
}
