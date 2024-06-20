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
    var isAvailable : Bool
    var userName : String
    
}

// api 에러가 발생했을때 에러 메세지 연결 을 위해 사용 (에러 발생여부, 에러 원인 기록)
struct APIErrorMesaage : Decodable {
    var error : Bool
    var reason : String
}

enum APIError: LocalizedError {
    case invalidResponse
    case invalidRequestError(String)
    case transportError(Error)
    case validationError(String)
    case decodingError(Error)
    case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let error):
            return "Transport error: \(error)"
        case .invalidResponse:
            return "Invalid response"
        case .validationError(let reason):
            return "Validation error: \(reason)"
        case .decodingError:
            return "The server returned data in an unexpected format. Try updating the app."
        case .serverError(let statusCode, let reason, let retryAfter):
            return "Server error with code \(statusCode), reason: \(reason ?? "no reason given"), retry after: \(retryAfter ?? "no retry after provided")"
        }
    }
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
