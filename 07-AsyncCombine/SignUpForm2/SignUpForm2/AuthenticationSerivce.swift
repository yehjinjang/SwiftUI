//
//  AuthenticationSerivce.swift
//  SignUpForm2
//
//  Created by 장예진 on 6/20/24.
//

import Foundation
import Combine

struct AuthenticationSerivce {
    func checkUserNameAvailablePublisher(userName: String) -> AnyPublisher<Bool, Error>{
        return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()

    }
}
