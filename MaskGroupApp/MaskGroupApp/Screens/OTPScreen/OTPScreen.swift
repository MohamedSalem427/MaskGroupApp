//
//  OTPScreen.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI

struct OTPScreen: View {
    private let otpCodeLength = 6
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm:OTPVM

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image("Mask Group 183")
                    Text("رمز التفعيل")
                        .foregroundColor(Color.init("moveColor"))
                        .font(.system(size: 20)).italic()
                        .padding(.trailing,8)
                    OTPTextFieldView(otpCodeLength: otpCodeLength,
                                     verificationCode: $vm.verificationCode)
                    .frame(width: 160, height: 50)
                    
                    Divider()
                        .padding(.horizontal,80)
                                        Spacer().frame(height: 32)
                    Button {
                        vm.otpCustomer(phone: vm.phoneNumber)
                    } label: {
                        HStack{
                            Text("أعد الإرسال")
                                .foregroundColor(.red)
                                .font(.system(size: 16)).italic()
                        }
                    }
                    Spacer()
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("Group 51")
                                .frame(width: 32, height: 32)
                        }
                        .padding(.leading , 60)
                        .padding(.bottom , 100)
                        Spacer()
                    }
                    
                }
                .ignoresSafeArea()
            }.navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $vm.moveToHomeScreen) { HomeScreen(vm: .init()) }
             .activityIndicator(loadingState: vm.loading)
        }
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        OTPScreen(vm: OTPVM(phoneNumber: "+201150105720"))
    }
}

extension OTPScreen {
    static func build(phoneNumber:String) -> OTPScreen {
        let vm = OTPVM(phoneNumber: phoneNumber)
        return OTPScreen(vm: vm)
    }
}
