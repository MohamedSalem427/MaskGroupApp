//
//  BreedsUseCases.swift
//  CodersList
//
//  Created by Mohamed Salem on 23/03/2022.
//

import Foundation
import Combine
 protocol UserUseCasesProtocol {
 func login(otp: String, phone: String) -> AnyPublisher<LoginResponse, MiddlewareError>
 func otpCustomer(phone: String) -> AnyPublisher<SendOtpResponse, MiddlewareError>
 func getAvailableServices() -> AnyPublisher<ServicesResponse, MiddlewareError>
}
 struct UserUseCases: UserUseCasesProtocol {
 let middleware:UserMiddleWareProtocol
 init(middleware:UserMiddleWareProtocol = UserMiddleWareService()) {
        self.middleware = middleware
    }
     func login(otp: String, phone: String) -> AnyPublisher<LoginResponse, MiddlewareError>{
        return middleware.login(otp: otp, phone: phone).flatMap { response -> AnyPublisher<LoginResponse, MiddlewareError> in
            Deferred {
                Future { promise in
                    promise(.success(response))
                }
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
     func otpCustomer(phone: String) -> AnyPublisher<SendOtpResponse, MiddlewareError>{
        return middleware.otpCustomer(phone: phone).flatMap { response -> AnyPublisher<SendOtpResponse, MiddlewareError> in
            Deferred {
                Future { promise in
                    promise(.success(response))
                }
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
     func getAvailableServices() -> AnyPublisher<ServicesResponse, MiddlewareError> {
        return middleware.getAvailableServices().flatMap { response -> AnyPublisher<ServicesResponse, MiddlewareError> in
            Deferred {
                Future { promise in
                    promise(.success(response))
                }
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
