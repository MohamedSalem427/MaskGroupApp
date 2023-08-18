//
//  LoginScreen.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import SwiftUI

struct LoginScreen: View {
    @ObservedObject var vm:LoginVM
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("Mask Group 183")
                    HStack {
                        Spacer()
                        WelComeView().padding()
                    }
                    EnterPhoneView()
                    LoginView().activityIndicator(loadingState: vm.loading)
                }
            }
            
            .ignoresSafeArea()
                .onReceive(vm.$moveToOTPScreen) { move in
                    if move {
                        presentOTPScreen()
                    }
                }
                
        }
    }
    
    private func WelComeView() -> some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Text("مرحبًا بك")
                    .foregroundColor(Color.init("moveColor"))
                    .font(.system(size: 30)).italic()
                    .padding(.trailing,8)
            }
            Spacer().frame(height: 10)
            HStack {
                Spacer()
                Text("استمتع بأفضل خدماتنا ....")
                    .foregroundColor(.black)
                    .font(.system(size: 20)).italic()
                    .padding(.trailing,8)
            }
        }
    }
    private func EnterPhoneView() -> some View {
        VStack {
            HStack {
                Image("Group 49")
                    .frame(width: 24,height: 34)
                    .padding(.leading,40)
                TextField("إدخال رقم الهاتف", text: $vm.phone)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing,40)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
            }
            Divider()
                .padding(.trailing,40)
        }
    }
    private func LoginView() -> some View {
        HStack {
            Button {
            } label: {
                Image("Group 51")
                    .frame(width: 32, height: 32)
            }
            
            VStack {
                Button {
                    vm.checkPhone()
                } label: {
                    HStack{
                        Spacer()
                        Text("تسجيل الدخول")
                            .foregroundColor(Color.init("moveColor"))
                            .font(.system(size: 20)).italic()
                    }
                    
                }
                Spacer().frame(height: 32)
                Button {
                    vm.checkPhone()
                } label: {
                    HStack{
                        Spacer()
                        Text("التسجيل كمؤسسة؟")
                            .foregroundColor(.red)
                            .font(.system(size: 16)).italic()
                    }
                }
            }
        }.padding(.all , 60)
    }
    
    private func presentOTPScreen() {
        viewController?.present(builder: {
            NavigationView {
                OTPScreen(vm: .init(phoneNumber: vm.phone))
            }
        })
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(vm: LoginVM())
    }
}




