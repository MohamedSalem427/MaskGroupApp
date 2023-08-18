//
//  OTPVM.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Foundation

class OTPVM: ObservableObject {
    private let cancellableBag = CancellableBag()
    let loading: LoadingState = LoadingState()
    private let  useCases: UserUseCasesProtocol = UserUseCases()
    @Published var moveToHomeScreen:Bool = false
    @Published var verificationCode:String = ""
    @Published var isVerificationCodeFull:Bool = false
    let phoneNumber:String
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        $verificationCode
                .delay(for: .milliseconds(500), scheduler: RunLoop.main)
                .sink { [weak self] in
                    guard let self = self else {
                        return
                    }
                    // Use isVerificationCodeFull to avoid submitting multiple times
                    if !self.isVerificationCodeFull && $0.count == 6 {
                        self.login(otp: self.verificationCode, phone: phoneNumber)
                    }
                    self.isVerificationCodeFull = $0.count == 6
                }.store(in: cancellableBag)
    }
   
    func login(otp: String, phone: String) {
        loading.isLoading = true
        useCases.login(otp: otp, phone: phone)
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .sinkToResult { [weak self] in
                self?.loading.isLoading = false
                switch $0 {
                case let .success(value):
                    if value.statusCode == 201 || value.statusCode == 200 {
                        self?.handlResponse(response: value)
                        self?.moveToHomeScreen = true
                    }else {
                        Alert().showWithCancelButton(with: .alert, title: "Fail", message: value.message ?? "")
                    }
                case let .failure(error):
                    Alert().showWithCancelButton(with: .alert, title: "Fail", message: error.errorDescription ?? "")
                }
            }.store(in: cancellableBag)
    }
    
    func otpCustomer(phone: String) {
        loading.isLoading = true
        useCases.otpCustomer(phone: phone)
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .sinkToResult { [weak self] in
                self?.loading.isLoading = false
                switch $0 {
                case let .success(value):
                    if value.statusCode == 201 || value.statusCode == 200 {
                        Alert().showWithCancelButton(with: .alert, title: "Success", message: value.message ?? "")
                    }else {
                        Alert().showWithCancelButton(with: .alert, title: "Fail", message: value.message ?? "")
                    }
                case let .failure(error):
                    Alert().showWithCancelButton(with: .alert, title: "Fail", message: error.errorDescription ?? "")
                }
            }.store(in: cancellableBag)
    }
    
    private func handlResponse(response: LoginResponse) {
        UserDefaults.standard.set(response.data?.accessToken, key: .accessToken)
        UserDefaults.standard.set(true, key: .isLoggedIn)
    }
}



