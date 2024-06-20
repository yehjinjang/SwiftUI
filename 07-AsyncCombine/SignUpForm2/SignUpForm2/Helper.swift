//
//  Helper.swift
//  SignUpForm2
//
//  Created by 장예진 on 6/20/24.
//

import Foundation
import Combine

// decode 하기 위해 쓰기 때문에 Codable 사용
struct UserNameAvailableMessage : Codable {
    var isVailable : Bool
    var userName : String
    
}

// api 에러가 발생했을때 에러 메세지 연결 을 위해 사용 (에러 발생여부, 에러 원인 기록)
struct APIErrorMesaage : Decodable {
    var error : Bool
    var reason : String
}

enum APIError : LocalizedError {
    case invalidResponse
}

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never>{
        self.map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
        
        
    }
}
