//
//  CurrencyTextField.swift
//  window-shopper
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {

    private func customizeView() {
        layer.cornerRadius = 5.0
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textAlignment = NSTextAlignment.center
        clipsToBounds = true
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
            attributedPlaceholder = place
        }
    }
    
    // MARK: - UITextField
    
    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: (frame.size.height  / 2 - size / 2), width: size, height: size))
        currencyLbl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.205490757)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        currencyLbl.layer.cornerRadius = 5.0
        currencyLbl.clipsToBounds = true
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        currencyLbl.text = formatter.currencySymbol
        
        addSubview(currencyLbl)
    }
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
}
