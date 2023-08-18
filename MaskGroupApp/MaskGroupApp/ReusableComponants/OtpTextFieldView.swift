//
//  OtpTextFieldView.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI
import Combine

public struct OTPTextFieldView: View {
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    let otpCodeLength:Int
    @Binding var verificationCode:String
    init(otpCodeLength: Int,
         verificationCode: Binding<String>
    ) {
        self.otpCodeLength = otpCodeLength
        _verificationCode = verificationCode
        UITextField.appearance().clearButtonMode = .never
        UITextField.appearance().tintColor = UIColor.clear
    }
    private var backgroundTextField: some View {
        return TextField("", text: $verificationCode)
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .accentColor(.blue)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .field)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                {
                    self.focusedField = .field
                }
            }
            .padding()
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            backgroundTextField
            HStack {
                ForEach(0..<otpCodeLength) { index in
                    ZStack {
                        Text(getPin(at: index))
                            .font(Font.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.init("moveColor"))
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.init("moveColor"))
                            .padding(.trailing, 5)
                            .padding(.leading, 5)
                            .opacity(verificationCode.count <= index ? 1 : 0)
                    }
                }
            }
        }
    }
}

extension OTPTextFieldView {
    func getPin(at index: Int) -> String {
        guard self.verificationCode.count > index else {
            return ""
        }
        return String(Array(verificationCode)[index])
    }
}
