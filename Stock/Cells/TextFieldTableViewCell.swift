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
}

extension TextFieldTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        inputField.padding(width: 10, height: Float(inputField.frame.height))
    }
}
