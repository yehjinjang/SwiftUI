//
//  SignUpViewModel.swift
//  SignUpForm2
//
//  Created by 장예진 on 6/20/24.
//

import Foundation
import Combine

class SignUpFormViewModel: ObservableObject {
    typealias Available = Result<Bool,Error>
    
    @Published var username: String = ""
    @Published var usernameMessage: String = ""
    @Published var isValid: Bool = false
    @Published var showUpdateDialog: Bool = false
    
    
    private var authenticationService = AuthenticationService()
    
    private lazy var isUserNameAvailablePublisher : AnyPublisher<Bool, Never> = {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap{ username -> AnyPublisher<Bool, Never> in
                self.authenticationService.checkUserNameAvailablePublisher(userName: username)
                    .asResult()
                
            }
            .share()
            .eraseToAnyPublisher()
    }()
}
