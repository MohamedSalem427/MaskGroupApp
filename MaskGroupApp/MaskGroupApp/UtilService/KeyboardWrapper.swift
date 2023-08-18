//
//  KeyboardWrapper.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import IQKeyboardManagerSwift
import SwiftUI
public class KeyboardWrapper {
    public class func handleKeyboardAppearance() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
    }
}
