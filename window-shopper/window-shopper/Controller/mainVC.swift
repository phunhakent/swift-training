//
//  ViewController.swift
//  window-shopper
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @objc func calculate() {
        if let wageText = wageTxt.text, let priceText = priceTxt.text {
            if let wage = Double(wageText), let price = Double(priceText) {
                view.endEditing(true)
                
                resultLbl.isHidden = false
                hoursLbl.isHidden = false
                
                resultLbl.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
                
            }
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var wageTxt: CurrencyTextField!
    @IBOutlet weak var priceTxt: CurrencyTextField!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    // MARK: - IBAction
    @IBAction func onClearCalculatorPressed(_ sender: UIButton) {
        hoursLbl.isHidden = true
        resultLbl.isHidden = true
        
        wageTxt.text = ""
        priceTxt.text = ""
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        
        calcBtn.backgroundColor = #colorLiteral(red: 0.9601275325, green: 0.6548269391, blue: 0.2234641314, alpha: 1)
        calcBtn.setTitle("Calculate", for: .normal)
        calcBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        calcBtn.addTarget(self, action: #selector(MainVC.calculate), for: .touchUpInside)
        
        wageTxt.inputAccessoryView = calcBtn
        priceTxt.inputAccessoryView = calcBtn
    }
}

