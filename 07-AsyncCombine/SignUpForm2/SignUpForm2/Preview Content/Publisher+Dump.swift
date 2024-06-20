//
//  Publisher+Dump.swift
//  SignUpForm2
//
//  Created by 장예진 on 6/20/24.
//

import Foundation
import Combine
// 범용 으로 사용하기 위한 generic pattern 사용
extension Publisher {
    func dump() -> AnyPublisher<Self.Output, Self.Failure> {
        handleEvents(receiveSubscription: { value in
            Swift.dump(value)
        })
        .eraseToAnyPublisher()
    }
}
