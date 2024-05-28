//
//  ContentView.swift
//  GLoginPrace
//
//  Created by 장예진 on 5/1/24.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift

extension AuthenticationViewModel {
    @ObservedObject static var shared = AuthenticationViewModel()
}

struct RegistrationView: View {
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @AppStorage("storedName") private var storedName: String = ""
    @AppStorage("storedEmail") private var storedEmail: String = ""
    @AppStorage("userID") private var userID: String = ""
    @StateObject private var authenticationViewModel = AuthenticationViewModel.shared

    var body: some View {
        VStack {
            Spacer()
            Text("Packing").font(.custom("New York-Bold", size: 30)).font(.title)
            Text("여행의 목적에 맞는 짐싸기").font(.custom("New York-Bold", size: 20)).font(.title)
            Spacer()

            if authenticationViewModel.state == .signedOut && userName.isEmpty {
                VStack(spacing: 10) {
                    SignInWithAppleButton(.signIn, onRequest: onRequest, onCompletion: onCompletion)
                        .frame(height: 44)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: authenticationViewModel.login) {
                        HStack {
                            Image("googleIcon") // Use a proper Google logo image asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.leading, 20)
                            Spacer()
                            Text("Continue with Google")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                    }
                }
            } else if authenticationViewModel.state == .signedIn {
                Text("Welcome, Packing \n\(userName), \(userEmail)")
                    .foregroundStyle(.black)
                    .font(.headline)
            }
            Spacer()
        }
        .background(Color(hex: 0xBDCDD6))
        .edgesIgnoringSafeArea(.all)
        .task {
            await authorize()
            authenticationViewModel.restorePreviousSignIn()
        }
    }

    private func authorize() async {
        guard !userID.isEmpty else {
            userName = ""
            userEmail = ""
            return
        }
        guard let credentialState = try? await ASAuthorizationAppleIDProvider()
            .credentialState(forUserID: userID), credentialState == .authorized else {
                userName = ""
                userEmail = ""
                return
            }
        userName = storedName
        userEmail = storedEmail
    }

    private func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }

    private func onCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            guard let credential = authResult.credential as? ASAuthorizationAppleIDCredential else { return }
            storedName = credential.fullName?.givenName ?? ""
            storedEmail = credential.email ?? ""
            userID = credential.user
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
