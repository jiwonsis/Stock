import Foundation

class Group: Codable {
    
    static let didDelete = NSNotification.Name(rawValue: "group.didDelete")
    
    var title: String
    var note: String?
    
    init(title: String, note: String?) {
        self.title = title
        self.note = note
    }
}
