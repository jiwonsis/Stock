import UIKit

extension UIColor {
    
    static var themeBlue: UIColor {
        return UIColor(hexString: "2961BB")
    }
    
    static var textDark: UIColor {
        return UIColor(hexString: "141517")
    }
    
    static var backgroundView: UIColor {
        return UIColor(hexString: "f2f4f5")
    }
    
    static var separator: UIColor {
        return UIColor(hexString: "0c141c").withAlphaComponent(0.1)
    }
    
    static var upRed: UIColor {
        return UIColor(hexString: "d40400")
    }
    
    static var downBlue: UIColor {
        return UIColor(hexString: "005dde")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
