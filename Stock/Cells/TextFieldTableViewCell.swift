//
//  TextFieldTableViewCell.swift
//  Stock
//
//  Created by Scott moon on 04/12/2017.
//  Copyright © 2017 Scott moon. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    var didChageStringValue: ((String?) -> Void)?
    
}

extension TextFieldTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        inputField.padding(width: 10, height: Float(inputField.frame.height))
        inputField.addTarget(self, action: #selector(onChange), for: .editingChanged)
    }
}

extension TextFieldTableViewCell {
    
    @objc func onChange(_ inputField: UITextField) {
        didChageStringValue?(inputField.text)
    }
    
    func isPassUserInput(text: String?) -> Bool {
        if "" == text { return false }
        return "" != text?.trimmingCharacters(in: .whitespaces)
    }
    
}
