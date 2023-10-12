import Foundation
import ulessonshared

@MainActor class HomeViewModel: ObservableObject {
    let subjects = [
        Subject(title: "Mathematics", image: "maths"),
        Subject(title: "English", image: "english"),
        Subject(title: "Biology", image: "biology"),
        Subject(title: "Chemistry", image: "chemistry"),
        Subject(title: "Physics", image: "physics"),
        Subject(title: "Government", image: "government"),
        Subject(title: "Accounting", image: "accounting"),
        Subject(title: "Economics", image: "economics"),
        Subject(title: "Literature", image: "literature"),
    ]
    
    @Published var query: String = ""
    @Published private(set) var selectedSubject: Subject? = nil
    @Published var goToChapterDetails = false
    
    // TODO: Calculate and set this in the ViewModel's init block
    @Published var overlayOpen = false
    
    private let dailyLoginUseCase = DailyLoginUseCase()
    
    init() {
        let lastLoginDate = dailyLoginUseCase.lastLoginDate()
        if lastLoginDate == nil || !Calendar.current.isDateInToday(Date(timeIntervalSince1970: lastLoginDate!.doubleValue / 1000)) {
            overlayOpen = true
            dailyLoginUseCase.storeLastLoginDate(dateMillis: Int64(Date.now.timeIntervalSince1970 * 1000.0))
        }
    }
    
    func updateSubject(_ subject: Subject) {
        if (subject.title == "Biology") {
            selectedSubject = subject
            goToChapterDetails = true
        }
    }
    
    func dismissDailyLogin() {
        overlayOpen = false
    }
}
