import Foundation

class Group: Codable {
    var title: String
    var note: String?
    
    init(title: String, note: String?) {
        self.title = title
        self.note = note
    }
}
