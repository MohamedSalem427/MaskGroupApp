//
//  LoginVM.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 17/08/2023.
//

import Combine
import Foundation

class LoginVM: ObservableObject {
    private let cancellableBag = CancellableBag()
    let loading: LoadingState = LoadingState()
    private let  useCases: UserUseCasesProtocol = UserUseCases()
    @Published var moveToOTPScreen:Bool = false
    @Published var phone: String = ""
    private var result:SendOtpResponse = SendOtpResponse()
    func checkPhone() {
        guard !phone.isEmpty else {
            Alert().showWithCancelButton(with: .alert, title: "Message", message: "Please Enter phone Number")
            return
        }
        phone = "\("+216")\(phone)"
        otpCustomer(phone: phone)
    }
    private func otpCustomer(phone: String) {
        loading.isLoading = true
        useCases.otpCustomer(phone: phone)
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .sinkToResult { [weak self] in
                self?.loading.isLoading = false
                switch $0 {
                case let .success(value):
                    if value.statusCode == 201 || value.statusCode == 200 {
                        self?.moveToOTPScreen = true
                    }else {
                        Alert().showWithCancelButton(with: .alert, title: "Fail", message: value.message ?? "")
                    }
                case let .failure(error):
                    Alert().showWithCancelButton(with: .alert, title: "Fail", message: error.errorDescription ?? "")
                }
            }.store(in: cancellableBag)
    }
}
