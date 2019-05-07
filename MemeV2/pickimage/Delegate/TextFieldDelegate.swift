//
//  TextFieldDelegata.swift
//  pickimage
//
//  Created by Sayed  on 4/21/19.
//  Copyright © 2019 Sayed . All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextFieldDelegate : NSObject, UITextFieldDelegate

class TextFieldDelegate : NSObject, UITextFieldDelegate {
    
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor:  UIColor.black,
        NSAttributedString.Key.foregroundColor:  UIColor.white ,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.6
        
    ]
    
}
