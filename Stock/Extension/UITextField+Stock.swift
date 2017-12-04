import UIKit

extension UITextField {
    func padding(width: Float, height: Float) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        self.leftViewMode = .always
    }
}
