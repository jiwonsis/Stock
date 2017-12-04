import UIKit

extension UITableView {
    func hideBottonSeperator() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
    }
}

