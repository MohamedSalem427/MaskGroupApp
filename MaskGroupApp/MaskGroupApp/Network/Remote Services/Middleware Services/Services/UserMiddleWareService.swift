//
//  UserMiddleWareService.swift
//  CodersList
//
//  Created by Mohamed Salem on 23/03/2022.
//

import Foundation
import Combine

 protocol UserMiddleWareProtocol {
    func login(otp: String, phone: String) -> AnyPublisher<LoginResponse, MiddlewareError>
    func otpCustomer(phone: String) -> AnyPublisher<SendOtpResponse, MiddlewareError>
    func getAvailableServices() -> AnyPublisher<ServicesResponse, MiddlewareError>
}

 class UserMiddleWareService: MiddlewareService<UserEndPoint>,UserMiddleWareProtocol {
    func login(otp: String, phone: String) -> AnyPublisher<LoginResponse, MiddlewareError>{
        return request(target: .login(otp: otp, phone: phone))
    }
    func otpCustomer(phone: String) -> AnyPublisher<SendOtpResponse, MiddlewareError> {
        return request(target: .otpCustomer(phone: phone))
    }
    func getAvailableServices() -> AnyPublisher<ServicesResponse, MiddlewareError> {
        return request(target: .availableServices)
    }
}
