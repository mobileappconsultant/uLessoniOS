
class Subject: Identifiable, Equatable, Hashable {
    static func == (lhs: Subject, rhs: Subject) -> Bool {
        return lhs.title == rhs.title && lhs.image == rhs.image
    }
    
    let title: String
    let image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(image)
    }
}
